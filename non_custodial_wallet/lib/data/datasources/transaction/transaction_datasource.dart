import 'package:web3dart/web3dart.dart';
import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'package:non_custodial_wallet/domain/entities/token/token_entity.dart';
import 'package:non_custodial_wallet/ui/core/constants/blockchain_constants.dart';
import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:non_custodial_wallet/ui/core/util/app_logger.dart';
import 'package:non_custodial_wallet/domain/entities/transaction/gas_estimate_entity.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';
import '../shared/wallet_key_deriver.dart';

abstract class ITransactionDataSource {
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  });

  Future<Result<String>> sendTokenTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    required TokenEntity token,
  });

  Future<Result<GasEstimateEntity>> estimateGas({
    required String fromAddress,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    TokenEntity? token,
  });
}

class TransactionDataSourceImpl implements ITransactionDataSource {
  final Map<int, Web3Client> clients;
  final WalletKeyDeriver keyDeriver;

  static final _erc20Abi = ContractAbi.fromJson(
    BlockchainConstants.erc20TransferAbi,
    'ERC20',
  );

  TransactionDataSourceImpl({
    required this.clients,
    required this.keyDeriver,
  });

  @override
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  }) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }
    try {
      final credentials = keyDeriver.deriveCredentials(mnemonic);
      try {
        final txHash = await client.sendTransaction(
          credentials,
          Transaction(
            to: EthereumAddress.fromHex(toAddress),
            value: EtherAmount.inWei(amountInWei),
          ),
          chainId: network.chainId,
        );
        return Result.success(txHash);
      } finally {
        keyDeriver.zeroOutKey(credentials);
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error sending transaction on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure('Transaction failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<String>> sendTokenTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    required TokenEntity token,
  }) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }
    try {
      final credentials = keyDeriver.deriveCredentials(mnemonic);
      try {
        final contract = DeployedContract(
          _erc20Abi,
          EthereumAddress.fromHex(token.contractAddress),
        );
        final transfer =
            contract.function(BlockchainConstants.transferFunction);
        final txHash = await client.sendTransaction(
          credentials,
          Transaction.callContract(
            contract: contract,
            function: transfer,
            parameters: [
              EthereumAddress.fromHex(toAddress),
              amount,
            ],
          ),
          chainId: network.chainId,
        );
        return Result.success(txHash);
      } finally {
        keyDeriver.zeroOutKey(credentials);
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error sending ${token.symbol} on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure('Token transfer failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<GasEstimateEntity>> estimateGas({
    required String fromAddress,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    TokenEntity? token,
  }) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }
    try {
      final from = EthereumAddress.fromHex(fromAddress);
      final to = EthereumAddress.fromHex(toAddress);

      BigInt gasUnits;

      if (token != null) {
        final contract = DeployedContract(
          _erc20Abi,
          EthereumAddress.fromHex(token.contractAddress),
        );
        final transfer = contract.function(BlockchainConstants.transferFunction);
        final data = transfer.encodeCall([to, amount]);

        gasUnits = await client.estimateGas(
          sender: from,
          to: contract.address,
          data: data,
        );
      } else {
        gasUnits = await client.estimateGas(
          sender: from,
          to: to,
          value: EtherAmount.inWei(amount),
        );
      }

      final gasPrice = await client.getGasPrice();

      return Result.success(GasEstimateEntity(
        estimatedGas: gasUnits,
        gasPrice: gasPrice.getInWei,
      ));
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error estimating gas on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure('Gas estimation failed: ${e.toString()}'),
      );
    }
  }
}
