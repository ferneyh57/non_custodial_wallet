import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../core/constants/app_faucets.dart';
import '../../core/extensions/context_extension.dart';
import 'widgets/faucet_item.dart';

class FaucetScreen extends StatelessWidget {
  const FaucetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.faucetTitle,
          style: AppFonts.style(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.faucetSubtitle,
                style: AppFonts.style(
                  color: context.appColors.subtitleText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: AppFaucets.current.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final faucet = AppFaucets.current[index];
                    return FaucetItem(
                      faucet: faucet,
                      onTap: () => _openFaucet(context, faucet.url),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openFaucet(BuildContext context, String url) async {
    final address =
        context.read<WalletCubit>().state.wallet?.ethAddress ?? '';
    if (address.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: address));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.copiedToClipboard),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
