/// Represents a single signature request within a prepared call.
class SwapSignatureRequest {
  final String type; // "eip7702Auth" or "personal_sign"
  final String rawPayload;

  const SwapSignatureRequest({
    required this.type,
    required this.rawPayload,
  });
}

class SwapQuoteEntity {
  final String chainId;
  final String type; // "array"
  final String preparedDataJson; // JSON-encoded data array for sendPreparedCalls
  final String expiry;
  final String fromAmount;
  final String minimumToAmount;
  final bool isSponsored;
  final List<SwapSignatureRequest> signatureRequests;

  const SwapQuoteEntity({
    required this.chainId,
    required this.type,
    required this.preparedDataJson,
    required this.expiry,
    required this.fromAmount,
    required this.minimumToAmount,
    required this.isSponsored,
    required this.signatureRequests,
  });
}
