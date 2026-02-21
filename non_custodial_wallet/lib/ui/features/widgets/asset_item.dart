import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/mixins/block_explorer_mixin.dart';

class AssetItem extends StatelessWidget with BlockExplorerMixin {
  final IconData icon;
  final String name;
  final String symbol;
  final String address;
  final Color color;
  final String? imageUrl;
  final double? price;

  const AssetItem({
    super.key,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.address,
    required this.color,
    this.imageUrl,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.2),
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl!)
                    : null,
                child: imageUrl == null ? Icon(icon, color: color) : null,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      symbol,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '0.00',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (price != null)
                    Text(
                      NumberFormat.currency(symbol: '\$').format(price),
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white10),
          const SizedBox(height: 5),
          Text(
            context.l10n.addressLabel,
            style: GoogleFonts.poppins(color: Colors.white60, fontSize: 10),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => openBlockExplorer(context, address, symbol),
                  child: Text(
                    address,
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blueAccent,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: address));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.copiedToClipboard),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, color: Colors.white, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: context.l10n.copyTooltip,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
