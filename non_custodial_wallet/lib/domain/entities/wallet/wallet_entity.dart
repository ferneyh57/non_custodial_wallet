class WalletEntity {
  final String mnemonic;
  final String? ethAddress;

  const WalletEntity({
    required this.mnemonic,
    this.ethAddress,
  });

  WalletEntity copyWith({
    String? mnemonic,
    String? ethAddress,
  }) {
    return WalletEntity(
      mnemonic: mnemonic ?? this.mnemonic,
      ethAddress: ethAddress ?? this.ethAddress,
    );
  }
}
