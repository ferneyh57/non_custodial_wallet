import 'package:flutter/widgets.dart';
import 'package:non_custodial_wallet/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
