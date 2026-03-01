class WalletEntity {
  final String? ethAddress;
  final Map<int, BigInt> balancesInWei;

  const WalletEntity({
    this.ethAddress,
    this.balancesInWei = const {},
  });

  double balanceInEth(int chainId) {
    final wei = balancesInWei[chainId];
    if (wei == null) return 0.0;
    return wei / BigInt.from(10).pow(18);
  }

  double get totalBalanceInEth {
    if (balancesInWei.isEmpty) return 0.0;
    return balancesInWei.values
        .fold(BigInt.zero, (sum, wei) => sum + wei)
        .toDouble() /
        1e18;
  }

  WalletEntity copyWith({
    String? ethAddress,
    Map<int, BigInt>? balancesInWei,
  }) {
    return WalletEntity(
      ethAddress: ethAddress ?? this.ethAddress,
      balancesInWei: balancesInWei ?? this.balancesInWei,
    );
  }
}
