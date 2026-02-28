import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:typed_data';
import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:non_custodial_wallet/ui/core/util/app_logger.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';

abstract class ITransactionDataSource {
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  });
}

class TransactionDataSourceImpl implements ITransactionDataSource {
  final Map<int, Web3Client> clients;

  TransactionDataSourceImpl({required this.clients});

  @override
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  }) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/60'/0'/0/0");
      final privateKey = Uint8List.fromList(child.privateKey!);
      final credentials = EthPrivateKey.fromHex(HEX.encode(privateKey));

      final txHash = await client.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(toAddress),
          value: EtherAmount.inWei(amountInWei),
        ),
        chainId: network.chainId,
      );

      return Result.success(txHash);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error sending transaction on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure('Transaction failed: ${e.toString()}'),
      );
    }
  }
}
