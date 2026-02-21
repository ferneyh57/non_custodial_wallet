// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Non Wallet';

  @override
  String get welcomeSubtitle =>
      'Tu puerta de entrada no-custodial a BTC, ETH y USDC.';

  @override
  String get createWalletButton => 'CREAR UNA NUEVA BILLETERA';

  @override
  String get importWalletButton => 'Ya tengo una billetera';

  @override
  String get homeTitle => 'Mi Billetera';

  @override
  String get logoutTooltip => 'Cerrar sesión';

  @override
  String get secretPhraseTitle => 'Frase Secreta';

  @override
  String get secretPhraseInstructions =>
      'Escribe o copia estas palabras en el orden correcto y guárdalas en un lugar seguro.';

  @override
  String get doneButton => 'HECHO';

  @override
  String get importWalletTitle => 'Importar Billetera';

  @override
  String get importWalletInstructions =>
      'Ingresa tu frase mnemónica de 12 o 24 palabras.';

  @override
  String get mnemonicHint => 'palabra1 palabra2 ...';

  @override
  String get importButton => 'IMPORTAR';

  @override
  String get addressLabel => 'Dirección:';

  @override
  String get totalBalanceLabel => 'Saldo Total';

  @override
  String get loading => 'Cargando...';

  @override
  String get copyMnemonic => 'Copiar Frase';

  @override
  String get mnemonicCopied => 'Frase mnemónica copiada al portapapeles';

  @override
  String error(String message) {
    return 'Error: $message';
  }
}
