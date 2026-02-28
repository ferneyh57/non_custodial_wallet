class TokenEntity {
  final String contractAddress;
  final String symbol;
  final String name;
  final int decimals;
  final String logoUrl;

  const TokenEntity({
    required this.contractAddress,
    required this.symbol,
    required this.name,
    required this.decimals,
    this.logoUrl = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenEntity &&
          runtimeType == other.runtimeType &&
          contractAddress.toLowerCase() == other.contractAddress.toLowerCase();

  @override
  int get hashCode => contractAddress.toLowerCase().hashCode;
}
