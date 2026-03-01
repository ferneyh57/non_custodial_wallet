import 'network_constants.dart';

class FaucetLink {
  final String name;
  final String url;
  final String iconUrl;

  const FaucetLink({
    required this.name,
    required this.url,
    required this.iconUrl,
  });
}

class AppFaucets {
  static bool get isAvailable => AppEnvironment.isTestnet;

  static List<FaucetLink> get current =>
      AppEnvironment.isTestnet ? sepolia : const [];

  static const _ethIcon =
      'https://assets.coingecko.com/coins/images/279/large/ethereum.png';
  static const _usdcIcon =
      'https://assets.coingecko.com/coins/images/6319/large/usdc.png';
  static const _linkIcon =
      'https://assets.coingecko.com/coins/images/877/large/chainlink-new-logo.png';
  static const _opIcon =
      'https://assets.coingecko.com/coins/images/25244/large/Optimism.png';
  static const _arbIcon =
      'https://assets.coingecko.com/coins/images/16547/large/photo_2023-03-29_21.47.00.jpeg';
  static const _baseIcon =
      'https://assets.coingecko.com/coins/images/279/large/ethereum.png';
  static const _polIcon =
      'https://assets.coingecko.com/coins/images/14073/large/matic.png';

  static const List<FaucetLink> sepolia = [
    // ETH Sepolia
    FaucetLink(
      name: 'Alchemy — ETH Sepolia',
      url: 'https://www.alchemy.com/faucets/ethereum-sepolia',
      iconUrl: _ethIcon,
    ),
    FaucetLink(
      name: 'Google Cloud — ETH Sepolia',
      url: 'https://cloud.google.com/application/web3/faucet/ethereum/sepolia',
      iconUrl: _ethIcon,
    ),
    // Stablecoins
    FaucetLink(
      name: 'Circle — USDC Testnet',
      url: 'https://faucet.circle.com/',
      iconUrl: _usdcIcon,
    ),
    // LINK
    FaucetLink(
      name: 'Chainlink — LINK Sepolia',
      url: 'https://faucets.chain.link/sepolia',
      iconUrl: _linkIcon,
    ),
    // L2 Faucets
    FaucetLink(
      name: 'Alchemy — Base Sepolia',
      url: 'https://www.alchemy.com/faucets/base-sepolia',
      iconUrl: _baseIcon,
    ),
    FaucetLink(
      name: 'Alchemy — Arbitrum Sepolia',
      url: 'https://www.alchemy.com/faucets/arbitrum-sepolia',
      iconUrl: _arbIcon,
    ),
    FaucetLink(
      name: 'Alchemy — Optimism Sepolia',
      url: 'https://www.alchemy.com/faucets/optimism-sepolia',
      iconUrl: _opIcon,
    ),
    FaucetLink(
      name: 'Alchemy — Polygon Amoy',
      url: 'https://www.alchemy.com/faucets/polygon-amoy',
      iconUrl: _polIcon,
    ),
  ];
}
