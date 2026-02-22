import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_constants.dart';

mixin SocialMixin {
  Future<void> openBlockExplorer(
    BuildContext context,
    String address,
    String symbol,
  ) async {
    String urlStr = '';
    final curSymbol = symbol.toLowerCase();

    if (curSymbol == AppConstants.bitcoinSymbol.toLowerCase()) {
      urlStr = '${AppConstants.btcExplorerUrl}$address';
    } else if (curSymbol == AppConstants.ethereumSymbol.toLowerCase() ||
        curSymbol == AppConstants.usdCoinSymbol.toLowerCase()) {
      urlStr = '${AppConstants.ethExplorerUrl}$address';
    } else {
      urlStr = '${AppConstants.ethExplorerUrl}$address';
    }

    final url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open block explorer')),
        );
      }
    }
  }

  Future<void> copyToClipboard(
    BuildContext context,
    String text,
    String successMessage,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successMessage),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> shareText(String text, {String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }
}
