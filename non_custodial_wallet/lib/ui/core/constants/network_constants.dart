class AppEnvironment {
  static const String _env = String.fromEnvironment(
    'ENV',
    defaultValue: 'testnet',
  );

  static bool get isTestnet => _env == 'testnet';
  static bool get isMainnet => _env == 'mainnet';
}

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
