import '../../../domain/entities/token/token_entity.dart';
import 'network_constants.dart';

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

  static Map<int, List<TokenEntity>> get tokensByChain =>
      AppEnvironment.isMainnet ? _mainnetTokensByChain : _testnetTokensByChain;

  // --- Testnet ---
  static const Map<int, List<TokenEntity>> _testnetTokensByChain = {
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

  // --- Mainnet ---
  static const Map<int, List<TokenEntity>> _mainnetTokensByChain = {
    // Ethereum
    1: [
      TokenEntity(
        contractAddress: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
      TokenEntity(
        contractAddress: '0x514910771AF9Ca656af840dff83E8264EcF986CA',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c',
        symbol: 'EURC',
        name: 'Euro Coin',
        decimals: 6,
        logoUrl: _eurcLogo,
      ),
    ],
    // Optimism
    10: [
      TokenEntity(
        contractAddress: '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6',
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
    // Polygon
    137: [
      TokenEntity(
        contractAddress: '0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xb0897686c545045aFc77CF20eC7A532E3120E0F1',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
    ],
    // Arbitrum One
    42161: [
      TokenEntity(
        contractAddress: '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xf97f4df75117a78c1A5a0DBb814Af92458539FB4',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x82aF49447D8a07e3bd95BD0d56f35241523fBab1',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
    ],
    // Base
    8453: [
      TokenEntity(
        contractAddress: '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
        symbol: 'USDC',
        name: 'USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196',
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
        contractAddress: '0x60a3E35Cc302bFA44Cb288Bc5a4F316Fdb1adb42',
        symbol: 'EURC',
        name: 'Euro Coin',
        decimals: 6,
        logoUrl: _eurcLogo,
      ),
    ],
  };
}
