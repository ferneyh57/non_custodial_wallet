class GasEstimateEntity {
  final BigInt estimatedGas;
  final BigInt gasPrice;

  const GasEstimateEntity({
    required this.estimatedGas,
    required this.gasPrice,
  });

  BigInt get totalFeeWei => estimatedGas * gasPrice;

  String get formattedFee {
    final fee = totalFeeWei;
    final whole = fee ~/ BigInt.from(10).pow(18);
    final fraction = fee.remainder(BigInt.from(10).pow(18));
    final fractionStr = fraction.toString().padLeft(18, '0').substring(0, 6);
    return '$whole.$fractionStr';
  }
}
