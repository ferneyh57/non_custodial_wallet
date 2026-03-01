class SwapStatusEntity {
  final String callId;
  final int status;
  final String? transactionHash;

  const SwapStatusEntity({
    required this.callId,
    required this.status,
    this.transactionHash,
  });

  bool get isPending => status == 100 || status == 120;
  bool get isConfirmed => status == 200;
  bool get isFailed => status >= 400;

  String get statusLabel {
    switch (status) {
      case 100:
        return 'Pending';
      case 120:
        return 'Cross-chain in progress';
      case 200:
        return 'Confirmed';
      case 400:
        return 'Offchain failure';
      case 410:
        return 'Refunded';
      case 500:
        return 'Onchain failure';
      case 600:
        return 'Partial failure';
      default:
        return 'Unknown';
    }
  }
}
