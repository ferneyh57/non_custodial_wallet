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
  static const _ethIcon =
      'https://assets.coingecko.com/coins/images/279/small/ethereum.png';
  static const _usdcIcon =
      'https://assets.coingecko.com/coins/images/6319/small/usdc.png';
  static const _linkIcon =
      'https://assets.coingecko.com/coins/images/877/small/chainlink-new-logo.png';

  static const List<FaucetLink> sepolia = [
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
    FaucetLink(
      name: 'Circle — USDC Testnet',
      url: 'https://faucet.circle.com/',
      iconUrl: _usdcIcon,
    ),
    FaucetLink(
      name: 'Chainlink — LINK Sepolia',
      url: 'https://faucets.chain.link/sepolia',
      iconUrl: _linkIcon,
    ),
  ];
}
