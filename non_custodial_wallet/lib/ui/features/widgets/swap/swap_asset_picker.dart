import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../cubits/swap/swap_cubit.dart';

class SwapAssetPicker extends StatefulWidget {
  final List<SwapAsset> assets;
  final String title;

  const SwapAssetPicker({
    super.key,
    required this.assets,
    required this.title,
  });

  /// Shows the picker and returns the selected [SwapAsset], or null if dismissed.
  static Future<SwapAsset?> show(
    BuildContext context, {
    required List<SwapAsset> assets,
    required String title,
  }) {
    return showModalBottomSheet<SwapAsset>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SwapAssetPicker(assets: assets, title: title),
    );
  }

  @override
  State<SwapAssetPicker> createState() => _SwapAssetPickerState();
}

class _SwapAssetPickerState extends State<SwapAssetPicker> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SwapAsset> get _filtered {
    if (_query.isEmpty) return widget.assets;
    final q = _query.toLowerCase();
    return widget.assets.where((a) {
      return a.symbol.toLowerCase().contains(q) ||
          a.name.toLowerCase().contains(q) ||
          a.networkName.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final maxHeight = MediaQuery.of(context).size.height * 0.75;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.appColors.hintText.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _query = '');
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
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: context.appColors.cardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: context.appColors.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: context.colors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Asset list
          Flexible(
            child: filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      context.l10n.noStableFound,
                      style: GoogleFonts.poppins(
                        color: context.appColors.subtitleText,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final asset = filtered[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _AssetListItem(
                          asset: asset,
                          onTap: () => Navigator.of(context).pop(asset),
                        )
                            .animate()
                            .fadeIn(
                              delay: Duration(
                                milliseconds: 40 * (index < 10 ? index : 10),
                              ),
                              duration: const Duration(milliseconds: 300),
                            )
                            .slideY(
                              begin: 0.05,
                              delay: Duration(
                                milliseconds: 40 * (index < 10 ? index : 10),
                              ),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _AssetListItem extends StatelessWidget {
  final SwapAsset asset;
  final VoidCallback onTap;

  const _AssetListItem({required this.asset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColors.cardBorder),
          ),
          child: Row(
            children: [
              // Token icon with network badge
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          context.colors.primary.withValues(alpha: 0.12),
                      backgroundImage: asset.iconUrl.isNotEmpty
                          ? NetworkImage(asset.iconUrl)
                          : null,
                      onBackgroundImageError:
                          asset.iconUrl.isNotEmpty ? (_, _) {} : null,
                      child: asset.iconUrl.isEmpty
                          ? Text(
                              asset.symbol[0],
                              style: GoogleFonts.poppins(
                                color: context.colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.appColors.cardColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: context.appColors.cardColor,
                          backgroundImage: asset.networkIconUrl.isNotEmpty
                              ? NetworkImage(asset.networkIconUrl)
                              : null,
                          onBackgroundImageError:
                              asset.networkIconUrl.isNotEmpty
                                  ? (_, _) {}
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.symbol,
                      style: GoogleFonts.poppins(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      asset.networkName,
                      style: GoogleFonts.poppins(
                        color: context.appColors.subtitleText,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: context.appColors.subtitleText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
