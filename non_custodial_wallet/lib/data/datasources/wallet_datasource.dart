import 'package:bip39/bip39.dart' as bip39;
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';
import '../../../ui/core/util/app_logger.dart';
import '../../../ui/core/error/exceptions.dart';

abstract class WalletDataSource {
  String generateMnemonic();
  bool validateMnemonic(String mnemonic);
  Future<String> getEthAddress(String mnemonic);
  Future<String> getBtcAddress(String mnemonic);
}

class WalletDataSourceImpl implements WalletDataSource {
  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  // ETH Address Derivation
  @override
  Future<String> getEthAddress(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/60'/0'/0/0");
      final privateKey = Uint8List.fromList(child.privateKey!);
      final credentials = EthPrivateKey.fromHex(HEX.encode(privateKey));
      return credentials.address.hexEip55;
    } catch (e, stackTrace) {
      AppLogger.error('Error deriving ETH address', e, stackTrace);
      throw ServerException('Failed to derive ETH address');
    }
  }

  // BTC Address Derivation (using BDK)
  @override
  Future<String> getBtcAddress(String mnemonic) async {
    try {
      final mnemonicObj = await bdk.Mnemonic.fromString(mnemonic);
      final descriptorSecretKey = await bdk.DescriptorSecretKey.create(
        network: bdk.Network.testnet, // Using Testnet for development
        mnemonic: mnemonicObj,
      );

      final externalDescriptor = await bdk.Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: bdk.Network.testnet,
        keychain: bdk.KeychainKind.externalChain,
      );

      final wallet = await bdk.Wallet.create(
        descriptor: externalDescriptor,
        network: bdk.Network.testnet,
        databaseConfig: const bdk.DatabaseConfig.memory(),
      );

      final addressInfo = wallet.getAddress(
        addressIndex: const bdk.AddressIndex.increase(),
      );

      return addressInfo.address.asString();
    } catch (e, stackTrace) {
      AppLogger.error('Error deriving BTC address', e, stackTrace);
      throw ServerException('Failed to derive BTC address');
    }
  }
}
