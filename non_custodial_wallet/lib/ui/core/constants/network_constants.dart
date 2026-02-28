class NetworkConstants {
  static const String alchemyApiKey = String.fromEnvironment(
    'ALCHEMY_API_KEY',
    defaultValue: '',
  );

  static const String alchemyPricesBaseUrl =
      'https://api.g.alchemy.com/prices/v1/';

  static String rpcUrl(String prefix) =>
      'https://$prefix.g.alchemy.com/v2/$alchemyApiKey';
}
