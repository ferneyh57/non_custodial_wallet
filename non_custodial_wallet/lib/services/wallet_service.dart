import 'package:bip39/bip39.dart' as bip39;
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';

class WalletService {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  // ETH Address Derivation
  Future<String> getEthAddress(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath("m/44'/60'/0'/0/0");
    final privateKey = Uint8List.fromList(child.privateKey!);
    final credentials = EthPrivateKey.fromHex(HEX.encode(privateKey));
    return credentials.address.hexEip55;
  }

  // BTC Address Derivation (using BDK)
  Future<String> getBtcAddress(String mnemonic) async {
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
  }
}
