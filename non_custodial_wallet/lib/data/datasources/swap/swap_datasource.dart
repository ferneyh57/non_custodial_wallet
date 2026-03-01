import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart' as crypto;
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/swap/swap_quote_entity.dart';
import '../../../domain/entities/swap/swap_status_entity.dart';
import '../../../ui/core/constants/crypto_constants.dart';
import '../../../ui/core/constants/rpc_methods.dart';
import '../../../ui/core/error/failures.dart';
import '../../../ui/core/util/result.dart';
import '../../../ui/core/util/app_logger.dart';
import '../shared/alchemy_rpc_client.dart';
import '../shared/wallet_key_deriver.dart';

abstract class ISwapDataSource {
  Future<Result<SwapQuoteEntity>> requestQuote({
    required String fromAddress,
    required NetworkEntity fromNetwork,
    required NetworkEntity toNetwork,
    required String fromTokenAddress,
    required String toTokenAddress,
    required BigInt fromAmount,
  });

  Future<Result<String>> executeSwap({
    required String mnemonic,
    required SwapQuoteEntity quote,
  });

  Future<Result<SwapStatusEntity>> getSwapStatus(String callId);
}

class SwapDataSourceImpl implements ISwapDataSource {
  final AlchemyRpcClient rpcClient;
  final WalletKeyDeriver keyDeriver;

  SwapDataSourceImpl({
    required this.rpcClient,
    required this.keyDeriver,
  });

  String _toHex(BigInt value) => '0x${value.toRadixString(16)}';

  String _chainIdToHex(int chainId) => '0x${chainId.toRadixString(16)}';

  Uint8List _hexToBytes(String hex) {
    final clean = hex.startsWith('0x') ? hex.substring(2) : hex;
    return Uint8List.fromList(HEX.decode(clean));
  }

  String _bytesToHex(Uint8List bytes) => '0x${HEX.encode(bytes)}';

  Uint8List _padTo32(Uint8List bytes) {
    if (bytes.length >= 32) return bytes.sublist(bytes.length - 32);
    final padded = Uint8List(32);
    padded.setRange(32 - bytes.length, 32, bytes);
    return padded;
  }

  @override
  Future<Result<SwapQuoteEntity>> requestQuote({
    required String fromAddress,
    required NetworkEntity fromNetwork,
    required NetworkEntity toNetwork,
    required String fromTokenAddress,
    required String toTokenAddress,
    required BigInt fromAmount,
  }) async {
    try {
      final result = await rpcClient.call(
        method: RpcMethods.requestQuote,
        params: [
          {
            'from': fromAddress,
            'chainId': _chainIdToHex(fromNetwork.chainId),
            'toChainId': _chainIdToHex(toNetwork.chainId),
            'fromToken': fromTokenAddress,
            'toToken': toTokenAddress,
            'fromAmount': _toHex(fromAmount),
          },
        ],
      );

      final quote = result['quote'] as Map<String, dynamic>?;
      final rawData = result['data'];

      // data can be a List (array type) or a Map (single user-operation fields)
      List<dynamic>? dataArray;
      if (rawData is List) {
        dataArray = rawData;
      } else if (rawData is Map) {
        final wrappedItem = <String, dynamic>{
          'type': result['type'] as String,
          'data': rawData,
          'chainId': result['chainId'] as String,
        };
        if (result.containsKey('signatureRequest')) {
          wrappedItem['signatureRequest'] = result['signatureRequest'];
        }
        if (result.containsKey('feePayment')) {
          wrappedItem['feePayment'] = result['feePayment'];
        }
        dataArray = [wrappedItem];
      }

      if (quote == null || dataArray == null) {
        throw Exception('Invalid quote response: missing quote or data');
      }

      final signatureRequests = <SwapSignatureRequest>[];
      bool isSponsored = false;

      for (final item in dataArray) {
        final itemMap = item as Map<String, dynamic>;
        final sigReq = itemMap['signatureRequest'] as Map<String, dynamic>?;

        if (sigReq != null) {
          final sigType = sigReq['type'] as String;
          String rawPayload;

          if (sigType == CryptoConstants.personalSign) {
            final sigData = sigReq['data'] as Map<String, dynamic>;
            rawPayload = sigData['raw'] as String;
          } else {
            rawPayload = sigReq['rawPayload'] as String;
          }

          signatureRequests.add(SwapSignatureRequest(
            type: sigType,
            rawPayload: rawPayload,
          ));
        }

        final feePayment = itemMap['feePayment'] as Map<String, dynamic>?;
        if (feePayment != null) {
          isSponsored = feePayment['sponsored'] == true;
        }
      }

      return Result.success(SwapQuoteEntity(
        chainId: result['chainId'] as String,
        type: result['type'] as String,
        preparedDataJson: jsonEncode(dataArray),
        expiry: quote['expiry'] as String,
        fromAmount: quote['fromAmount'] as String,
        minimumToAmount: quote['minimumToAmount'] as String,
        isSponsored: isSponsored,
        signatureRequests: signatureRequests,
      ));
    } on RpcException catch (e, stackTrace) {
      AppLogger.error('Error requesting swap quote', e, stackTrace);
      if (e.isSponsoredRequired) {
        return Result.failure(
          ServerFailure('SPONSORED_REQUIRED:${e.message}'),
        );
      }
      return Result.failure(
        ServerFailure('Failed to get swap quote: ${e.message}'),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Error requesting swap quote', e, stackTrace);
      return Result.failure(
        ServerFailure('Failed to get swap quote: ${e.toString()}'),
      );
    }
  }

  Map<String, dynamic> _signRequest(
    SwapSignatureRequest sigReq,
    EthPrivateKey credentials,
  ) {
    final payload = _hexToBytes(sigReq.rawPayload);

    if (sigReq.type == CryptoConstants.personalSign) {
      final sig = credentials.signPersonalMessageToUint8List(payload);
      return {'type': CryptoConstants.secp256k1, 'data': _bytesToHex(sig)};
    } else if (sigReq.type == CryptoConstants.eip7702Auth) {
      final msgSig = crypto.sign(payload, credentials.privateKey);
      final r = _padTo32(crypto.unsignedIntToBytes(msgSig.r));
      final s = _padTo32(crypto.unsignedIntToBytes(msgSig.s));
      final v = msgSig.v - 27; // y-parity (0 or 1)
      final sigBytes = Uint8List(65);
      sigBytes.setRange(0, 32, r);
      sigBytes.setRange(32, 64, s);
      sigBytes[64] = v;
      return {'type': CryptoConstants.secp256k1, 'data': _bytesToHex(sigBytes)};
    }

    throw Exception('Unknown signature type: ${sigReq.type}');
  }

  @override
  Future<Result<String>> executeSwap({
    required String mnemonic,
    required SwapQuoteEntity quote,
  }) async {
    try {
      final credentials = keyDeriver.deriveCredentials(mnemonic);
      final dataArray = jsonDecode(quote.preparedDataJson) as List<dynamic>;

      int sigIndex = 0;
      final signedItems = <Map<String, dynamic>>[];

      for (final item in dataArray) {
        final itemMap = Map<String, dynamic>.from(item as Map);
        final hasSigReq = itemMap.containsKey('signatureRequest');

        itemMap.remove('signatureRequest');

        if (hasSigReq && sigIndex < quote.signatureRequests.length) {
          itemMap['signature'] =
              _signRequest(quote.signatureRequests[sigIndex], credentials);
          sigIndex++;
        }

        signedItems.add(itemMap);
      }

      final requestParams = [
        {
          'type': 'array',
          'data': signedItems,
        },
      ];

      final result = await rpcClient.call(
        method: RpcMethods.sendPreparedCalls,
        params: requestParams,
      );

      final callId = result['id'] as String;
      return Result.success(callId);
    } catch (e, stackTrace) {
      AppLogger.error('Error executing swap', e, stackTrace);
      return Result.failure(
        ServerFailure('Swap execution failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<SwapStatusEntity>> getSwapStatus(String callId) async {
    try {
      final result = await rpcClient.call(
        method: RpcMethods.getCallsStatus,
        params: [callId],
      );

      final status = result['status'] as int;
      final receipts = result['receipts'] as List<dynamic>?;

      String? txHash;
      if (receipts != null && receipts.isNotEmpty) {
        final firstReceipt = receipts[0] as Map<String, dynamic>;
        txHash = firstReceipt['transactionHash'] as String?;
      }

      return Result.success(SwapStatusEntity(
        callId: result['id'] as String,
        status: status,
        transactionHash: txHash,
      ));
    } catch (e, stackTrace) {
      AppLogger.error('Error getting swap status', e, stackTrace);
      return Result.failure(
        ServerFailure('Failed to get swap status: ${e.toString()}'),
      );
    }
  }
}
