import '../../../domain/entities/token/token_entity.dart';

class AppTokens {
  // Logo URLs
  static const _usdcLogo =
      'https://assets.coingecko.com/coins/images/6319/small/usdc.png';
  static const _usdtLogo =
      'https://assets.coingecko.com/coins/images/325/small/Tether.png';
static const _linkLogo =
      'https://assets.coingecko.com/coins/images/877/small/chainlink-new-logo.png';
  static const _wethLogo =
      'https://assets.coingecko.com/coins/images/2518/small/weth.png';
  static const _eurcLogo =
      'https://assets.coingecko.com/coins/images/26045/small/euro-coin.png';

  static const Map<int, List<TokenEntity>> tokensByChain = {
    // Ethereum Sepolia
    11155111: [
      TokenEntity(
        contractAddress: '0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0x7169D38820dfd117C3FA1f22a697dBA58d90BA06',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
TokenEntity(
        contractAddress: '0x779877A7B0D9E8603169DdbD7836e478b4624789',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x08210F9170F89Ab7658F0B5E3fF39b0E03C594D4',
        symbol: 'EURC',
        name: 'Euro Coin',
        decimals: 6,
        logoUrl: _eurcLogo,
      ),
    ],
    // Optimism Sepolia
    11155420: [
      TokenEntity(
        contractAddress: '0x5fd84259d66Cd46123540766Be93DFE6D43130D7',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xE4aB69C077896252FAFBD49EFD26B5D171A32410',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
    ],
    // Polygon Amoy
    80002: [
      TokenEntity(
        contractAddress: '0x41E94Eb019C0762f9Bfcf9Fb1E58725BfB0e7582',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
    ],
    // Arbitrum Sepolia
    421614: [
      TokenEntity(
        contractAddress: '0x75faf114eafb1BDbe2F0316DF893fd58CE46AA4d',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xb1D4538B4571d411F07960EF2838Ce337FE1E80E',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x980B62Da83eFf3D4576C647993b0c1D7faf17c73',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
    ],
    // Base Sepolia
    84532: [
      TokenEntity(
        contractAddress: '0x036CbD53842c5426634e7929541eC2318f3dCF7e',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xE4aB69C077896252FAFBD49EFD26B5D171A32410',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x808456652fdb597867f38412077A9182bf77359F',
        symbol: 'EURC',
        name: 'Euro Coin',
        decimals: 6,
        logoUrl: _eurcLogo,
      ),
    ],
  };
}
