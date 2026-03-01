import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token_detail/token_detail_args.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../commons/cubits/token/token_state.dart';
import 'token_item.dart';

class HomeTokensList extends StatefulWidget {
  final TokenState tokenState;
  final Map<String, double> priceBySymbol;
  final List<NetworkEntity> networks;

  const HomeTokensList({
    super.key,
    required this.tokenState,
    required this.priceBySymbol,
    required this.networks,
  });

  @override
  State<HomeTokensList> createState() => _HomeTokensListState();
}

class _HomeTokensListState extends State<HomeTokensList> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tokenState.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CircularProgressIndicator(
            color: context.colors.primary,
          ),
        ),
      );
    }

    final chainIds = widget.networks.map((n) => n.chainId).toSet();
    final modeBalances = widget.tokenState.tokenBalances
        .where((tb) => chainIds.contains(tb.chainId))
        .toList();

    if (modeBalances.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            context.l10n.noStableFound,
            style: AppFonts.style(
              color: context.appColors.subtitleText,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    final networkNames = <int, String>{
      for (final network in widget.networks)
        network.chainId: network.shortName,
    };
    final networkIcons = <int, String>{
      for (final network in widget.networks)
        network.chainId: network.iconUrl,
    };

    final filtered = _query.isEmpty
        ? modeBalances
        : modeBalances.where((tb) {
            final q = _query.toLowerCase();
            return tb.token.symbol.toLowerCase().contains(q) ||
                tb.token.name.toLowerCase().contains(q) ||
                (networkNames[tb.chainId] ?? '').toLowerCase().contains(q);
          }).toList();

    return Column(
      children: [
        TokenSearchField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: 10),
        ...filtered.asMap().entries.map((entry) {
          final index = entry.key;
          final tb = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TokenItem(
              tokenBalance: tb,
              networkName: networkNames[tb.chainId] ?? '',
              networkIconUrl: networkIcons[tb.chainId] ?? '',
              price:
                  widget.priceBySymbol[tb.token.symbol.toUpperCase()],
              onTap: () {
                final network = widget.networks.firstWhere(
                  (n) => n.chainId == tb.chainId,
                );
                context.push(
                  AppRoutes.tokenDetail,
                  extra: TokenDetailArgs(
                    network: network,
                    tokenBalance: tb,
                    price: widget
                        .priceBySymbol[tb.token.symbol.toUpperCase()],
                  ),
                );
              },
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 80 * index),
                  duration: const Duration(milliseconds: 400),
                )
                .slideY(
                  begin: 0.1,
                  delay: Duration(milliseconds: 80 * index),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                ),
          );
        }),
      ],
    );
  }
}

class TokenSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TokenSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppFonts.style(
        color: context.colors.onSurface,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: context.l10n.searchTokenHint,
        hintStyle: AppFonts.style(
          color: context.appColors.subtitleText,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: context.appColors.subtitleText,
          size: 20,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                  onChanged('');
                },
                child: Icon(
                  Icons.close_rounded,
                  color: context.appColors.subtitleText,
                  size: 18,
                ),
              )
            : null,
        filled: true,
        fillColor: context.appColors.cardColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.appColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.appColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.colors.primary),
        ),
      ),
    );
  }
}
