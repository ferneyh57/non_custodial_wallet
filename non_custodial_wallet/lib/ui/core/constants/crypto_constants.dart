class CryptoConstants {
  // BIP44 derivation path for Ethereum
  static const String ethDerivationPath = "m/44'/60'/0'/0/0";

  // Native token placeholder address (Alchemy swap API)
  static const String nativeTokenAddress =
      '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';

  // Signature types
  static const String personalSign = 'personal_sign';
  static const String eip7702Auth = 'eip7702Auth';
  static const String secp256k1 = 'secp256k1';
}
