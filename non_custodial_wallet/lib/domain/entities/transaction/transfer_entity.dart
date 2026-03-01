class TransferEntity {
  final String hash;
  final String from;
  final String to;
  final double value;
  final String asset;
  final String category;
  final DateTime timestamp;
  final bool isSent;
  final int chainId;

  const TransferEntity({
    required this.hash,
    required this.from,
    required this.to,
    required this.value,
    required this.asset,
    required this.category,
    required this.timestamp,
    required this.isSent,
    required this.chainId,
  });
}
