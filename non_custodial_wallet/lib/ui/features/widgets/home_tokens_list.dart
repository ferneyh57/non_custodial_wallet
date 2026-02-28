import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../core/extensions/context_extension.dart';
import '../cubits/token/token_state.dart';
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

    if (widget.tokenState.tokenBalances.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            context.l10n.noStableFound,
            style: GoogleFonts.poppins(
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
        ? widget.tokenState.tokenBalances
        : widget.tokenState.tokenBalances.where((tb) {
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
      style: GoogleFonts.poppins(
        color: context.colors.onSurface,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: context.l10n.searchTokenHint,
        hintStyle: GoogleFonts.poppins(
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
