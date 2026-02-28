class NetworkConstants {
  static const String alchemyApiKey = String.fromEnvironment(
    'ALCHEMY_API_KEY',
    defaultValue: '',
  );

  static String get sepoliaRpcUrl =>
      'https://eth-sepolia.g.alchemy.com/v2/$alchemyApiKey';

  static const int sepoliaChainId = 11155111;
}
