// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Non Wallet';

  @override
  String get welcomeSubtitle => 'Your non-custodial gateway to ETH and USDC.';

  @override
  String get createWalletButton => 'CREATE A NEW WALLET';

  @override
  String get importWalletButton => 'I already have a wallet';

  @override
  String get homeTitle => 'My Wallet';

  @override
  String get logoutTooltip => 'Logout';

  @override
  String get secretPhraseTitle => 'Secret Phrase';

  @override
  String get secretPhraseInstructions =>
      'Write down or copy these words in the right order and save them somewhere safe.';

  @override
  String get doneButton => 'DONE';

  @override
  String get importWalletTitle => 'Import Wallet';

  @override
  String get importWalletInstructions =>
      'Enter your 12 or 24 word mnemonic phrase.';

  @override
  String get mnemonicHint => 'word1 word2 ...';

  @override
  String get importButton => 'Import';

  @override
  String get addressLabel => 'Address:';

  @override
  String get totalBalanceLabel => 'Total Balance';

  @override
  String get loading => 'Loading...';

  @override
  String get copyMnemonic => 'Copy Phrase';

  @override
  String get mnemonicCopied => 'Mnemonic copied to clipboard';

  @override
  String get copiedToClipboard => 'Address copied to clipboard';

  @override
  String get copyTooltip => 'Copy Address';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get sendButton => 'Send';

  @override
  String get receiveButton => 'Receive';

  @override
  String get sendTitle => 'Send';

  @override
  String get networkLabel => 'Network';

  @override
  String get addressHint => 'Recipient Address';

  @override
  String get amountHint => 'Amount';

  @override
  String get maxButton => 'MAX';

  @override
  String get sendAction => 'Send';

  @override
  String get themeToggleTooltip => 'Toggle theme';
}
