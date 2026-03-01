class RpcMethods {
  // Alchemy Token API
  static const String getTokenBalances = 'alchemy_getTokenBalances';

  // Alchemy Transfer History API
  static const String getAssetTransfers = 'alchemy_getAssetTransfers';

  // Alchemy Wallet/Swap API
  static const String requestQuote = 'wallet_requestQuote_v0';
  static const String sendPreparedCalls = 'wallet_sendPreparedCalls';
  static const String getCallsStatus = 'wallet_getCallsStatus';
}
