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

  @override
  String get networkTab => 'Networks';

  @override
  String get stableTab => 'Tokens';

  @override
  String get noStableFound => 'No tokens found';

  @override
  String get allNetworksFilter => 'All';

  @override
  String get swapButton => 'Swap';

  @override
  String get buyButton => 'Buy';

  @override
  String get faucetButton => 'Faucet';

  @override
  String get faucetTitle => 'Testnet Faucets';

  @override
  String get faucetSubtitle => 'Get free testnet tokens to try the wallet';

  @override
  String get searchTokenHint => 'Search token...';

  @override
  String get assetLabel => 'Asset';

  @override
  String get nativeAsset => 'Native';

  @override
  String get errorEmptyAddress => 'Address cannot be empty';

  @override
  String get errorInvalidAddress => 'Invalid address';

  @override
  String get errorInvalidAmount => 'Amount must be greater than zero';

  @override
  String get errorInsufficientBalance => 'Insufficient balance';

  @override
  String get errorLoadWallet => 'Failed to load wallet';

  @override
  String get txSentSuccess => 'Transaction Sent!';

  @override
  String get tokenDetailTitle => 'Token Details';

  @override
  String get contractAddressLabel => 'Contract Address';

  @override
  String get viewOnExplorer => 'View on Explorer';

  @override
  String get contractCopied => 'Contract address copied';

  @override
  String get estimatedFeeLabel => 'Estimated fee';

  @override
  String get estimatingFee => 'Estimating fee...';

  @override
  String get confirmSendTitle => 'Confirm Transaction';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get activityTab => 'Activity';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get swapTitle => 'Swap';

  @override
  String get fromNetworkLabel => 'From Network';

  @override
  String get toNetworkLabel => 'To Network';

  @override
  String get fromTokenLabel => 'From Token';

  @override
  String get toTokenLabel => 'To Token';

  @override
  String get getQuoteButton => 'Get Quote';

  @override
  String get swapAction => 'Swap';

  @override
  String get swapConfirmTitle => 'Confirm Swap';

  @override
  String get minimumReceived => 'Min. received';

  @override
  String get swapFeeLabel => 'Fee';

  @override
  String get swapSponsored => 'Sponsored';

  @override
  String get swapNotSponsored => 'Standard';

  @override
  String get swapSponsoredRequired =>
      'This network does not support swaps yet. Try a different network.';
}
