import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/token_detail/token_detail_args.dart';
import '../../../core/di.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../cubits/token_detail/token_detail_cubit.dart';
import '../../cubits/token_detail/token_detail_state.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../widgets/token_detail/token_detail_header.dart';
import '../../widgets/token_detail/token_detail_balance_card.dart';
import '../../widgets/token_detail/token_detail_info_section.dart';
import '../../widgets/token_detail/token_detail_actions.dart';

class TokenDetailScreen extends StatelessWidget {
  final TokenDetailArgs args;

  const TokenDetailScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TokenDetailCubit(
        args: args,
        getBalanceUseCase: sl(),
        getTokenBalancesUseCase: sl(),
      ),
      child: const TokenDetailScreenView(),
    );
  }
}

class TokenDetailScreenView extends StatelessWidget {
  const TokenDetailScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final walletAddress =
        context.read<WalletCubit>().state.wallet?.ethAddress ?? '';

    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        final args = state.args;
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
          body: RefreshIndicator(
            color: context.colors.primary,
            onRefresh: () => context
                .read<TokenDetailCubit>()
                .refreshBalance(walletAddress),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
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
                    isRefreshing: state.isRefreshing,
                  ),
                  const SizedBox(height: 24),
                  TokenDetailInfoSection(
                    networkName: args.network.shortName,
                    networkIconUrl: args.network.iconUrl,
                    contractAddress: args.contractAddress,
                  ),
                  const SizedBox(height: 24),
                  TokenDetailActions(
                    onSend: () => context.push(AppRoutes.send),
                    onReceive: () => context.push(AppRoutes.receive),
                    explorerUrl: explorerUrl,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
