import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Non Wallet'**
  String get appName;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your non-custodial gateway to ETH and USDC.'**
  String get welcomeSubtitle;

  /// No description provided for @createWalletButton.
  ///
  /// In en, this message translates to:
  /// **'CREATE A NEW WALLET'**
  String get createWalletButton;

  /// No description provided for @importWalletButton.
  ///
  /// In en, this message translates to:
  /// **'I already have a wallet'**
  String get importWalletButton;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get homeTitle;

  /// No description provided for @logoutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTooltip;

  /// No description provided for @secretPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Secret Phrase'**
  String get secretPhraseTitle;

  /// No description provided for @secretPhraseInstructions.
  ///
  /// In en, this message translates to:
  /// **'Write down or copy these words in the right order and save them somewhere safe.'**
  String get secretPhraseInstructions;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get doneButton;

  /// No description provided for @importWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Wallet'**
  String get importWalletTitle;

  /// No description provided for @importWalletInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your 12 or 24 word mnemonic phrase.'**
  String get importWalletInstructions;

  /// No description provided for @mnemonicHint.
  ///
  /// In en, this message translates to:
  /// **'word1 word2 ...'**
  String get mnemonicHint;

  /// No description provided for @importButton.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importButton;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressLabel;

  /// No description provided for @totalBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalanceLabel;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @copyMnemonic.
  ///
  /// In en, this message translates to:
  /// **'Copy Phrase'**
  String get copyMnemonic;

  /// No description provided for @mnemonicCopied.
  ///
  /// In en, this message translates to:
  /// **'Mnemonic copied to clipboard'**
  String get mnemonicCopied;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @copyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy Address'**
  String get copyTooltip;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// No description provided for @sendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// No description provided for @receiveButton.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receiveButton;

  /// No description provided for @sendTitle.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendTitle;

  /// No description provided for @networkLabel.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get networkLabel;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Recipient Address'**
  String get addressHint;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountHint;

  /// No description provided for @maxButton.
  ///
  /// In en, this message translates to:
  /// **'MAX'**
  String get maxButton;

  /// No description provided for @sendAction.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendAction;

  /// No description provided for @themeToggleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get themeToggleTooltip;

  /// No description provided for @networkTab.
  ///
  /// In en, this message translates to:
  /// **'Networks'**
  String get networkTab;

  /// No description provided for @stableTab.
  ///
  /// In en, this message translates to:
  /// **'Tokens'**
  String get stableTab;

  /// No description provided for @noStableFound.
  ///
  /// In en, this message translates to:
  /// **'No tokens found'**
  String get noStableFound;

  /// No description provided for @allNetworksFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allNetworksFilter;

  /// No description provided for @swapButton.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swapButton;

  /// No description provided for @buyButton.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyButton;

  /// No description provided for @faucetButton.
  ///
  /// In en, this message translates to:
  /// **'Faucet'**
  String get faucetButton;

  /// No description provided for @faucetTitle.
  ///
  /// In en, this message translates to:
  /// **'Testnet Faucets'**
  String get faucetTitle;

  /// No description provided for @faucetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get free testnet tokens to try the wallet'**
  String get faucetSubtitle;

  /// No description provided for @searchTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Search token...'**
  String get searchTokenHint;

  /// No description provided for @assetLabel.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get assetLabel;

  /// No description provided for @nativeAsset.
  ///
  /// In en, this message translates to:
  /// **'Native'**
  String get nativeAsset;

  /// No description provided for @errorEmptyAddress.
  ///
  /// In en, this message translates to:
  /// **'Address cannot be empty'**
  String get errorEmptyAddress;

  /// No description provided for @errorInvalidAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid address'**
  String get errorInvalidAddress;

  /// No description provided for @errorInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero'**
  String get errorInvalidAmount;

  /// No description provided for @errorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get errorInsufficientBalance;

  /// No description provided for @errorLoadWallet.
  ///
  /// In en, this message translates to:
  /// **'Failed to load wallet'**
  String get errorLoadWallet;

  /// No description provided for @txSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction Sent!'**
  String get txSentSuccess;

  /// No description provided for @tokenDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Token Details'**
  String get tokenDetailTitle;

  /// No description provided for @contractAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Contract Address'**
  String get contractAddressLabel;

  /// No description provided for @viewOnExplorer.
  ///
  /// In en, this message translates to:
  /// **'View on Explorer'**
  String get viewOnExplorer;

  /// No description provided for @contractCopied.
  ///
  /// In en, this message translates to:
  /// **'Contract address copied'**
  String get contractCopied;

  /// No description provided for @estimatedFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated fee'**
  String get estimatedFeeLabel;

  /// No description provided for @estimatingFee.
  ///
  /// In en, this message translates to:
  /// **'Estimating fee...'**
  String get estimatingFee;

  /// No description provided for @confirmSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Transaction'**
  String get confirmSendTitle;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @activityTab.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activityTab;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @swapTitle.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swapTitle;

  /// No description provided for @fromNetworkLabel.
  ///
  /// In en, this message translates to:
  /// **'From Network'**
  String get fromNetworkLabel;

  /// No description provided for @toNetworkLabel.
  ///
  /// In en, this message translates to:
  /// **'To Network'**
  String get toNetworkLabel;

  /// No description provided for @fromTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'From Token'**
  String get fromTokenLabel;

  /// No description provided for @toTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'To Token'**
  String get toTokenLabel;

  /// No description provided for @getQuoteButton.
  ///
  /// In en, this message translates to:
  /// **'Get Quote'**
  String get getQuoteButton;

  /// No description provided for @swapAction.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swapAction;

  /// No description provided for @swapConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Swap'**
  String get swapConfirmTitle;

  /// No description provided for @minimumReceived.
  ///
  /// In en, this message translates to:
  /// **'Min. received'**
  String get minimumReceived;

  /// No description provided for @swapFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get swapFeeLabel;

  /// No description provided for @swapSponsored.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get swapSponsored;

  /// No description provided for @swapNotSponsored.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get swapNotSponsored;

  /// No description provided for @swapSponsoredRequired.
  ///
  /// In en, this message translates to:
  /// **'This network does not support swaps yet. Try a different network.'**
  String get swapSponsoredRequired;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
