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
  final privateKeyData = child.privateKey;
  if (privateKeyData == null) {
    throw Exception('Failed to derive private key from seed');
  }
  final privateKey = Uint8List.fromList(privateKeyData);
  final address = EthPrivateKey.fromHex(HEX.encode(privateKey)).address.hexEip55;
  privateKey.fillRange(0, privateKey.length, 0);
  return address;
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
    final privateKeyData = child.privateKey;
    if (privateKeyData == null) {
      throw Exception('Failed to derive private key from seed');
    }
    final privateKey = Uint8List.fromList(privateKeyData);
    return EthPrivateKey.fromHex(HEX.encode(privateKey));
  }

  /// Zeros out the private key bytes of an EthPrivateKey after use.
  /// Note: Dart strings are immutable so the hex representation may linger,
  /// but this clears the underlying Uint8List where accessible.
  void zeroOutKey(EthPrivateKey key) {
    try {
      final bytes = key.privateKey;
      bytes.fillRange(0, bytes.length, 0);
    } catch (_) {
      // Best-effort: web3dart may not expose mutable bytes
    }
  }

  String deriveAddress(String mnemonic) {
    return deriveCredentials(mnemonic).address.hexEip55;
  }

  Future<String> deriveAddressAsync(String mnemonic) {
    return compute(_deriveAddressIsolate, mnemonic);
  }
}
