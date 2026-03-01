import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../core/extensions/context_extension.dart';
import '../../commons/cubits/network_mode/network_mode_cubit.dart';
import '../../commons/cubits/network_mode/network_mode_state.dart';
import '../../commons/cubits/theme/theme_cubit.dart';
import '../../commons/cubits/theme/theme_state.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/widgets/pin_verify_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.settingsTitle,
          style: AppFonts.style(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _NetworkModeSection(),
          _ThemeSection(),
          if (kDebugMode) _CopySeedSection(),
          _LogoutSection(),
        ],
      ),
    );
  }
}

class _NetworkModeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModeCubit, NetworkModeState>(
      builder: (context, state) {
        return SwitchListTile(
          secondary: Icon(
            Icons.lan_rounded,
            color: context.appColors.subtitleText,
          ),
          title: Text(
            context.l10n.settingsNetworkMode,
            style: AppFonts.style(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            state.isMainnet
                ? context.l10n.settingsNetworkModeMainnet
                : context.l10n.settingsNetworkModeTestnet,
            style: AppFonts.style(
              color: context.appColors.subtitleText,
              fontSize: 13,
            ),
          ),
          value: state.isMainnet,
          onChanged: (_) =>
              context.read<NetworkModeCubit>().toggleNetworkMode(),
        );
      },
    );
  }
}

class _ThemeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        return SwitchListTile(
          secondary: Icon(
            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            color: context.appColors.subtitleText,
          ),
          title: Text(
            context.l10n.settingsTheme,
            style: AppFonts.style(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            isDark
                ? context.l10n.settingsThemeDark
                : context.l10n.settingsThemeLight,
            style: AppFonts.style(
              color: context.appColors.subtitleText,
              fontSize: 13,
            ),
          ),
          value: isDark,
          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
        );
      },
    );
  }
}

class _CopySeedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.key_rounded, color: context.appColors.subtitleText),
      title: Text(
        context.l10n.settingsCopySeed,
        style: AppFonts.style(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        context.l10n.settingsCopySeedSubtitle,
        style: AppFonts.style(
          color: context.appColors.subtitleText,
          fontSize: 13,
        ),
      ),
      onTap: () async {
        final verified = await PinVerifySheet.show(context);
        if (!verified || !context.mounted) return;
        final mnemonic = context.read<WalletCubit>().state.wallet?.mnemonic;
        if (mnemonic != null) {
          Clipboard.setData(ClipboardData(text: mnemonic));
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(context.l10n.mnemonicCopied)));
        }
      },
    );
  }
}

class _LogoutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout_rounded, color: Colors.red),
      title: Text(
        context.l10n.settingsLogout,
        style: AppFonts.style(
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
      subtitle: Text(
        context.l10n.settingsLogoutSubtitle,
        style: AppFonts.style(
          color: context.appColors.subtitleText,
          fontSize: 13,
        ),
      ),
      onTap: () => _showLogoutDialog(context),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          context.l10n.settingsLogoutConfirmTitle,
          style: AppFonts.style(fontWeight: FontWeight.w600),
        ),
        content: Text(
          context.l10n.settingsLogoutConfirmMessage,
          style: AppFonts.style(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<WalletCubit>().logout();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.settingsLogoutConfirmButton),
          ),
        ],
      ),
    );
  }
}
