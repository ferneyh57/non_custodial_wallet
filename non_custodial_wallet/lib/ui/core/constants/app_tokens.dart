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
  static const _daiLogo =
      'https://assets.coingecko.com/coins/images/9956/small/Badge_Dai.png';
  static const _wbtcLogo =
      'https://assets.coingecko.com/coins/images/7598/small/wrapped_bitcoin_wbtc.png';
  static const _stethLogo =
      'https://assets.coingecko.com/coins/images/13442/small/steth_logo.png';
  static const _uniLogo =
      'https://assets.coingecko.com/coins/images/12504/small/uni.jpg';
  static const _aaveLogo =
      'https://assets.coingecko.com/coins/images/12645/small/AAVE.png';
  static const _cbethLogo =
      'https://assets.coingecko.com/coins/images/27008/small/cbeth.png';
  static const _arbLogo =
      'https://assets.coingecko.com/coins/images/16547/small/photo_2023-03-29_21.47.00.jpeg';
  static const _gmxLogo =
      'https://assets.coingecko.com/coins/images/18323/small/arbit.png';
  static const _opLogo =
      'https://assets.coingecko.com/coins/images/25244/small/Optimism.png';
  static const _wmaticLogo =
      'https://assets.coingecko.com/coins/images/14073/small/matic.png';
  static const _wstethLogo =
      'https://assets.coingecko.com/coins/images/18834/small/wstETH.png';

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
        contractAddress: '0x68194a729C2450ad26072b3D33ADaCbcef39D574',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x779877A7B0D9E8603169DdbD7836e478b4624789',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
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
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0xE4aB69C077896252FAFBD49EFD26B5D171A32410',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
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
      TokenEntity(
        contractAddress: '0xc199807AF4fEDB02EE567Ed0FeB814A077de4802',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
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
        contractAddress: '0x980B62Da83eFf3D4576C647993b0c1D7faf17c73',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0xb1D4538B4571d411F07960EF2838Ce337FE1E80E',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
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
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0xE4aB69C077896252FAFBD49EFD26B5D171A32410',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
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
        contractAddress: '0x6B175474E89094C44Da98b954EeDeAC495271d0F',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599',
        symbol: 'WBTC',
        name: 'Wrapped Bitcoin',
        decimals: 8,
        logoUrl: _wbtcLogo,
      ),
      TokenEntity(
        contractAddress: '0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84',
        symbol: 'stETH',
        name: 'Lido Staked Ether',
        decimals: 18,
        logoUrl: _stethLogo,
      ),
      TokenEntity(
        contractAddress: '0x514910771AF9Ca656af840dff83E8264EcF986CA',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984',
        symbol: 'UNI',
        name: 'Uniswap',
        decimals: 18,
        logoUrl: _uniLogo,
      ),
      TokenEntity(
        contractAddress: '0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9',
        symbol: 'AAVE',
        name: 'Aave',
        decimals: 18,
        logoUrl: _aaveLogo,
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
        contractAddress: '0x7F5c764cBc14f9669B88837ca1490cCa17c31607',
        symbol: 'USDC.e',
        name: 'Bridged USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0x94b008aA00579c1307B0EF2c499aD98a8ce58e58',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
      TokenEntity(
        contractAddress: '0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x4200000000000000000000000000000000000042',
        symbol: 'OP',
        name: 'Optimism',
        decimals: 18,
        logoUrl: _opLogo,
      ),
      TokenEntity(
        contractAddress: '0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb',
        symbol: 'wstETH',
        name: 'Wrapped Lido Staked Ether',
        decimals: 18,
        logoUrl: _wstethLogo,
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
        contractAddress: '0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174',
        symbol: 'USDC.e',
        name: 'Bridged USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xc2132D05D31c914a87C6611C10748AEb04B58e8F',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
      TokenEntity(
        contractAddress: '0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6',
        symbol: 'WBTC',
        name: 'Wrapped Bitcoin',
        decimals: 8,
        logoUrl: _wbtcLogo,
      ),
      TokenEntity(
        contractAddress: '0xb0897686c545045aFc77CF20eC7A532E3120E0F1',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270',
        symbol: 'WMATIC',
        name: 'Wrapped Matic',
        decimals: 18,
        logoUrl: _wmaticLogo,
      ),
      TokenEntity(
        contractAddress: '0xD6DF932A45C0f255f85145f286eA0b292B21C90B',
        symbol: 'AAVE',
        name: 'Aave',
        decimals: 18,
        logoUrl: _aaveLogo,
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
        contractAddress: '0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8',
        symbol: 'USDC.e',
        name: 'Bridged USD Coin',
        decimals: 6,
        logoUrl: _usdcLogo,
      ),
      TokenEntity(
        contractAddress: '0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
      TokenEntity(
        contractAddress: '0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0x82aF49447D8a07e3bd95BD0d56f35241523fBab1',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f',
        symbol: 'WBTC',
        name: 'Wrapped Bitcoin',
        decimals: 8,
        logoUrl: _wbtcLogo,
      ),
      TokenEntity(
        contractAddress: '0xf97f4df75117a78c1A5a0DBb814Af92458539FB4',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
      ),
      TokenEntity(
        contractAddress: '0x912CE59144191C1D603652e7D51a40c4CeAFb0e8',
        symbol: 'ARB',
        name: 'Arbitrum',
        decimals: 18,
        logoUrl: _arbLogo,
      ),
      TokenEntity(
        contractAddress: '0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a',
        symbol: 'GMX',
        name: 'GMX',
        decimals: 18,
        logoUrl: _gmxLogo,
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
        contractAddress: '0xfde4C96c8593536E31F229EA8f37b2ADa2699bb2',
        symbol: 'USDT',
        name: 'Tether USD',
        decimals: 6,
        logoUrl: _usdtLogo,
      ),
      TokenEntity(
        contractAddress: '0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb',
        symbol: 'DAI',
        name: 'Dai Stablecoin',
        decimals: 18,
        logoUrl: _daiLogo,
      ),
      TokenEntity(
        contractAddress: '0x4200000000000000000000000000000000000006',
        symbol: 'WETH',
        name: 'Wrapped Ether',
        decimals: 18,
        logoUrl: _wethLogo,
      ),
      TokenEntity(
        contractAddress: '0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22',
        symbol: 'cbETH',
        name: 'Coinbase Wrapped Staked Ether',
        decimals: 18,
        logoUrl: _cbethLogo,
      ),
      TokenEntity(
        contractAddress: '0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196',
        symbol: 'LINK',
        name: 'Chainlink',
        decimals: 18,
        logoUrl: _linkLogo,
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
