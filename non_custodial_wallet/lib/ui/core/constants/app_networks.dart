import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'network_constants.dart';

class AppNetworks {
  static NetworkEntity get ethSepolia => NetworkEntity(
        chainId: 11155111,
        name: 'Ethereum Sepolia',
        shortName: 'ETH Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('eth-sepolia'),
        explorerBaseUrl: 'https://sepolia.etherscan.io/address/',
        alchemyRpcPrefix: 'eth-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/279/small/ethereum.png',
      );

  static NetworkEntity get optSepolia => NetworkEntity(
        chainId: 11155420,
        name: 'Optimism Sepolia',
        shortName: 'OP Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('opt-sepolia'),
        explorerBaseUrl: 'https://sepolia-optimism.etherscan.io/address/',
        alchemyRpcPrefix: 'opt-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/25244/small/Optimism.png',
      );

  static NetworkEntity get polygonAmoy => NetworkEntity(
        chainId: 80002,
        name: 'Polygon Amoy',
        shortName: 'POL Amoy',
        nativeSymbol: 'POL',
        rpcUrl: NetworkConstants.rpcUrl('polygon-amoy'),
        explorerBaseUrl: 'https://amoy.polygonscan.com/address/',
        alchemyRpcPrefix: 'polygon-amoy',
        iconUrl: 'https://assets.coingecko.com/coins/images/4713/small/polygon.png',
      );

  static NetworkEntity get arbSepolia => NetworkEntity(
        chainId: 421614,
        name: 'Arbitrum Sepolia',
        shortName: 'ARB Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('arb-sepolia'),
        explorerBaseUrl: 'https://sepolia.arbiscan.io/address/',
        alchemyRpcPrefix: 'arb-sepolia',
        iconUrl: 'https://assets.coingecko.com/coins/images/16547/small/photo_2023-03-29_21.47.00.jpeg',
      );

  static NetworkEntity get baseSepolia => NetworkEntity(
        chainId: 84532,
        name: 'Base Sepolia',
        shortName: 'Base Sepolia',
        nativeSymbol: 'ETH',
        rpcUrl: NetworkConstants.rpcUrl('base-sepolia'),
        explorerBaseUrl: 'https://sepolia.basescan.org/address/',
        alchemyRpcPrefix: 'base-sepolia',
        iconUrl: 'https://assets.coingecko.com/asset_platforms/images/131/small/base.jpeg',
      );

  static List<NetworkEntity> get all => [
        ethSepolia,
        optSepolia,
        polygonAmoy,
        arbSepolia,
        baseSepolia,
      ];

  static NetworkEntity get defaultNetwork => ethSepolia;
}
