import 'package:bip39/bip39.dart' as bip39;
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';
import '../../../../ui/core/util/app_logger.dart';
import '../../../../ui/core/util/result.dart';

abstract class WalletDataSource {
  Future<Result<String>> getEthAddress(String mnemonic);
  Future<Result<String>> getBtcAddress(String mnemonic);
}

class WalletDataSourceImpl implements WalletDataSource {
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
  Future<Result<String>> getBtcAddress(String mnemonic) async {
    try {
      final mnemonicObj = await bdk.Mnemonic.fromString(mnemonic);
      final descriptorSecretKey = await bdk.DescriptorSecretKey.create(
        network: bdk.Network.testnet,
        mnemonic: mnemonicObj,
      );
      final externalDescriptor = await bdk.Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: bdk.Network.testnet,
        keychain: bdk.KeychainKind.externalChain,
      );

      final internalDescriptor = await bdk.Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: bdk.Network.testnet,
        keychain: bdk.KeychainKind.internalChain,
      );

      final wallet = await bdk.Wallet.create(
        descriptor: externalDescriptor,
        changeDescriptor: internalDescriptor,
        network: bdk.Network.testnet,
        databaseConfig: const bdk.DatabaseConfig.sqlite(
          config: bdk.SqliteDbConfiguration(path: 'bdk_wallet.db'),
        ),
      );

      final blockchainConfig = bdk.BlockchainConfig.electrum(
        config: bdk.ElectrumConfig(
          validateDomain: false,
          stopGap: BigInt.from(20),
          retry: 3,
          timeout: 10,
          url: 'ssl://electrum.blockstream.info:60002',
          socks5: null,
        ),
      );
      final blockchain = await bdk.Blockchain.create(config: blockchainConfig);

      await wallet.sync(blockchain: blockchain);

      final addressInfo = wallet.getAddress(
        addressIndex: bdk.AddressIndex.increase(),
      );
      return Result.success(addressInfo.address.asString());
    } catch (e, stackTrace) {
      AppLogger.error('Error deriving BTC address', e, stackTrace);
      return Result.failure(ServerFailure('Failed to derive BTC address'));
    }
  }
}
