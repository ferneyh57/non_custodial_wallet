import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/l10n/app_localizations.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_theme.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ColorScheme get colors => Theme.of(this).colorScheme;
  AppThemeExtension get appColors =>
      Theme.of(this).extension<AppThemeExtension>()!;
}
