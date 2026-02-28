class NetworkEntity {
  final int chainId;
  final String name;
  final String shortName;
  final String nativeSymbol;
  final String rpcUrl;
  final String explorerBaseUrl;
  final String alchemyRpcPrefix;
  final String iconUrl;

  const NetworkEntity({
    required this.chainId,
    required this.name,
    required this.shortName,
    required this.nativeSymbol,
    required this.rpcUrl,
    required this.explorerBaseUrl,
    required this.alchemyRpcPrefix,
    required this.iconUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NetworkEntity && other.chainId == chainId);

  @override
  int get hashCode => chainId.hashCode;

  @override
  String toString() => shortName;
}
