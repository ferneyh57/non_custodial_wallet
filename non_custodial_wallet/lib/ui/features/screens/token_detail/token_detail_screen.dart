import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/token_detail/token_detail_args.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../cubits/transfer_history/transfer_history_cubit.dart';
import '../../cubits/transfer_history/transfer_history_state.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../widgets/token_detail/token_detail_header.dart';
import '../../widgets/token_detail/token_detail_balance_card.dart';
import '../../widgets/token_detail/token_detail_info_section.dart';
import '../../widgets/token_detail/token_detail_actions.dart';
import '../../widgets/transaction/transaction_list.dart';

class TokenDetailScreen extends StatelessWidget {
  final TokenDetailArgs args;

  const TokenDetailScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final walletAddress =
        context.read<WalletCubit>().state.wallet?.ethAddress ?? '';

    final explorerUrl = args.isToken
        ? '${args.network.explorerBaseUrl.replaceFirst('/address/', '/token/')}${args.contractAddress}'
        : '${args.network.explorerBaseUrl}$walletAddress';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.tokenDetailTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            children: [
              TokenDetailHeader(
                iconUrl: args.iconUrl,
                name: args.displayName,
                symbol: args.symbol,
              ),
              const SizedBox(height: 24),
              TokenDetailBalanceCard(
                balance: args.balanceFormatted,
                symbol: args.symbol,
                usdValue: args.usdValue,
                price: args.price,
              ),
              const SizedBox(height: 24),
              TokenDetailInfoSection(
                networkName: args.network.shortName,
                networkIconUrl: args.network.iconUrl,
                walletAddress: walletAddress,
                contractAddress: args.contractAddress,
              ),
              const SizedBox(height: 24),
              TokenDetailActions(
                onSend: () => context.push(
                  AppRoutes.send,
                  extra: {
                    'network': args.network,
                    'token': args.tokenBalance?.token,
                  },
                ),
                onReceive: () => context.push(
                  AppRoutes.receive,
                  extra: {'network': args.network},
                ),
                onSwap: () => context.push(
                  AppRoutes.swap,
                  extra: {
                    'network': args.network,
                    'token': args.tokenBalance?.token,
                  },
                ),
                explorerUrl: explorerUrl,
              ),
              const SizedBox(height: 24),
              // Transaction history (filtered from global state)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.activityTab,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              BlocBuilder<TransferHistoryCubit, TransferHistoryState>(
                builder: (context, historyState) {
                  final filtered = historyState.transfers.where((t) {
                    if (t.chainId != args.network.chainId) return false;
                    if (args.isToken) {
                      return t.asset.toUpperCase() ==
                          args.tokenBalance!.token.symbol.toUpperCase();
                    }
                    return t.category == 'external';
                  }).toList();

                  return TransactionList(
                    transfers: filtered,
                    isLoading: false,
                    emptyMessage: context.l10n.noTransactionsFound,
                    networks: [args.network],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
