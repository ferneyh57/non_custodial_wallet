import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'network_constants.dart';

class AppNetworks {
  // --- Testnet ---
  static NetworkEntity get ethSepolia => NetworkEntity(
        chainId: 11155111,
        name: 'Ethereum Sepolia',
        shortName: 'ETH Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('eth-sepolia'),
        explorerBaseUrl: 'https://sepolia.etherscan.io/address/',
        alchemyRpcPrefix: 'eth-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
      );

  static NetworkEntity get optSepolia => NetworkEntity(
        chainId: 11155420,
        name: 'Optimism Sepolia',
        shortName: 'OP Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('opt-sepolia'),
        explorerBaseUrl: 'https://sepolia-optimism.etherscan.io/address/',
        alchemyRpcPrefix: 'opt-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/25244/large/Optimism.png',
      );

  static NetworkEntity get polygonAmoy => NetworkEntity(
        chainId: 80002,
        name: 'Polygon Amoy',
        shortName: 'POL Amoy',
        nativeSymbol: 'POL',
        rpcUrl: NetworkConstants.rpcUrl('polygon-amoy'),
        explorerBaseUrl: 'https://amoy.polygonscan.com/address/',
        alchemyRpcPrefix: 'polygon-amoy',
        iconUrl: 'https://assets.coingecko.com/coins/images/4713/large/polygon.png',
      );

  static NetworkEntity get arbSepolia => NetworkEntity(
        chainId: 421614,
        name: 'Arbitrum Sepolia',
        shortName: 'ARB Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('arb-sepolia'),
        explorerBaseUrl: 'https://sepolia.arbiscan.io/address/',
        alchemyRpcPrefix: 'arb-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/16547/large/photo_2023-03-29_21.47.00.jpeg',
      );

  static NetworkEntity get baseSepolia => NetworkEntity(
        chainId: 84532,
        name: 'Base Sepolia',
        shortName: 'Base Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('base-sepolia'),
        explorerBaseUrl: 'https://sepolia.basescan.org/address/',
        alchemyRpcPrefix: 'base-sepolia',
        iconUrl: 'https://assets.coingecko.com/asset_platforms/images/131/large/base.jpeg',
      );

  // --- Mainnet ---
  static NetworkEntity get ethMainnet => NetworkEntity(
        chainId: 1,
        name: 'Ethereum',
        shortName: 'ETH',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('eth-mainnet'),
        explorerBaseUrl: 'https://etherscan.io/address/',
        alchemyRpcPrefix: 'eth-mainnet',
        iconUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
      );

  static NetworkEntity get optMainnet => NetworkEntity(
        chainId: 10,
        name: 'Optimism',
        shortName: 'OP',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('opt-mainnet'),
        explorerBaseUrl: 'https://optimistic.etherscan.io/address/',
        alchemyRpcPrefix: 'opt-mainnet',
        iconUrl: 'https://assets.coingecko.com/coins/images/25244/large/Optimism.png',
      );

  static NetworkEntity get polygonMainnet => NetworkEntity(
        chainId: 137,
        name: 'Polygon',
        shortName: 'POL',
        nativeSymbol: 'POL',
        rpcUrl: NetworkConstants.rpcUrl('polygon-mainnet'),
        explorerBaseUrl: 'https://polygonscan.com/address/',
        alchemyRpcPrefix: 'polygon-mainnet',
        iconUrl: 'https://assets.coingecko.com/coins/images/4713/large/polygon.png',
      );

  static NetworkEntity get arbMainnet => NetworkEntity(
        chainId: 42161,
        name: 'Arbitrum One',
        shortName: 'ARB',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('arb-mainnet'),
        explorerBaseUrl: 'https://arbiscan.io/address/',
        alchemyRpcPrefix: 'arb-mainnet',
        iconUrl: 'https://assets.coingecko.com/coins/images/16547/large/photo_2023-03-29_21.47.00.jpeg',
      );

  static NetworkEntity get baseMainnet => NetworkEntity(
        chainId: 8453,
        name: 'Base',
        shortName: 'Base',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('base-mainnet'),
        explorerBaseUrl: 'https://basescan.org/address/',
        alchemyRpcPrefix: 'base-mainnet',
        iconUrl: 'https://assets.coingecko.com/asset_platforms/images/131/large/base.jpeg',
      );

  // --- Environment-aware getters ---
  static List<NetworkEntity> get _testnetAll => [
        ethSepolia,
        optSepolia,
        polygonAmoy,
        arbSepolia,
        baseSepolia,
      ];

  static List<NetworkEntity> get _mainnetAll => [
        ethMainnet,
        optMainnet,
        polygonMainnet,
        arbMainnet,
        baseMainnet,
      ];

  static List<NetworkEntity> get all =>
      AppEnvironment.isMainnet ? _mainnetAll : _testnetAll;

  static NetworkEntity get defaultNetwork =>
      AppEnvironment.isMainnet ? ethMainnet : ethSepolia;
}
