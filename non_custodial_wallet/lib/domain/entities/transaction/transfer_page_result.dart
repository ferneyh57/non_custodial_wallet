import 'transfer_entity.dart';

class TransferPageResult {
  final List<TransferEntity> transfers;
  final String? sentPageKey;
  final String? receivedPageKey;

  const TransferPageResult({
    required this.transfers,
    this.sentPageKey,
    this.receivedPageKey,
  });

  bool get hasMore => sentPageKey != null || receivedPageKey != null;
}
