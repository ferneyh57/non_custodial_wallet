import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/foundation.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import '../../../ui/core/constants/crypto_constants.dart';

String _deriveAddressIsolate(String mnemonic) {
  final seed = bip39.mnemonicToSeed(mnemonic);
  final root = bip32.BIP32.fromSeed(seed);
  final child = root.derivePath(CryptoConstants.ethDerivationPath);
  final privateKey = Uint8List.fromList(child.privateKey!);
  return EthPrivateKey.fromHex(HEX.encode(privateKey)).address.hexEip55;
}

/// Derives Ethereum credentials from a BIP39 mnemonic phrase.
///
/// Uses the standard BIP44 path m/44'/60'/0'/0/0 for Ethereum.
class WalletKeyDeriver {
  const WalletKeyDeriver();

  EthPrivateKey deriveCredentials(String mnemonic) {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath(CryptoConstants.ethDerivationPath);
    final privateKey = Uint8List.fromList(child.privateKey!);
    return EthPrivateKey.fromHex(HEX.encode(privateKey));
  }

  String deriveAddress(String mnemonic) {
    return deriveCredentials(mnemonic).address.hexEip55;
  }

  Future<String> deriveAddressAsync(String mnemonic) {
    return compute(_deriveAddressIsolate, mnemonic);
  }
}
