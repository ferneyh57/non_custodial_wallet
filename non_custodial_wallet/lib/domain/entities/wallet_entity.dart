class WalletEntity {
  final String mnemonic;
  final String? btcAddress;
  final String? ethAddress;

  const WalletEntity({
    required this.mnemonic,
    this.btcAddress,
    this.ethAddress,
  });

  WalletEntity copyWith({
    String? mnemonic,
    String? btcAddress,
    String? ethAddress,
  }) {
    return WalletEntity(
      mnemonic: mnemonic ?? this.mnemonic,
      btcAddress: btcAddress ?? this.btcAddress,
      ethAddress: ethAddress ?? this.ethAddress,
    );
  }
}
