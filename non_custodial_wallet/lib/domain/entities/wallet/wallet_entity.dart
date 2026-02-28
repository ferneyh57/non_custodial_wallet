class WalletEntity {
  final String mnemonic;
  final String? ethAddress;
  final BigInt? balanceInWei;

  const WalletEntity({
    required this.mnemonic,
    this.ethAddress,
    this.balanceInWei,
  });

  double get balanceInEth {
    if (balanceInWei == null) return 0.0;
    return balanceInWei! / BigInt.from(10).pow(18);
  }

  WalletEntity copyWith({
    String? mnemonic,
    String? ethAddress,
    BigInt? balanceInWei,
  }) {
    return WalletEntity(
      mnemonic: mnemonic ?? this.mnemonic,
      ethAddress: ethAddress ?? this.ethAddress,
      balanceInWei: balanceInWei ?? this.balanceInWei,
    );
  }
}
