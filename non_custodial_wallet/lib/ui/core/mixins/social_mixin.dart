import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../../domain/entities/network/network_entity.dart';

mixin SocialMixin {
  Future<void> openBlockExplorer(
    BuildContext context,
    String address,
    NetworkEntity network,
  ) async {
    final urlStr = '${network.explorerBaseUrl}$address';

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
