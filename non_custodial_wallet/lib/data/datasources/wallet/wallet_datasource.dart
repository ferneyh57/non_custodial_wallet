import 'package:bip39/bip39.dart' as bip39;
import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';
import '../../../../ui/core/util/app_logger.dart';
import '../../../../ui/core/util/result.dart';

abstract class WalletDataSource {
  Future<Result<String>> getEthAddress(String mnemonic);
  Future<Result<BigInt>> getBalance(String address);
}

class WalletDataSourceImpl implements WalletDataSource {
  final Web3Client web3client;

  WalletDataSourceImpl({required this.web3client});

  @override
  Future<Result<String>> getEthAddress(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/60'/0'/0/0");
      final privateKey = Uint8List.fromList(child.privateKey!);
      final credentials = EthPrivateKey.fromHex(HEX.encode(privateKey));
      return Result.success(credentials.address.hexEip55);
    } catch (e, stackTrace) {
      AppLogger.error('Error deriving ETH address', e, stackTrace);
      return Result.failure(ServerFailure('Failed to derive ETH address'));
    }
  }

  @override
  Future<Result<BigInt>> getBalance(String address) async {
    try {
      final ethAddress = EthereumAddress.fromHex(address);
      final balance = await web3client.getBalance(ethAddress);
      return Result.success(balance.getInWei);
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching ETH balance', e, stackTrace);
      return Result.failure(ServerFailure('Failed to fetch balance'));
    }
  }
}
