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
      'Tu puerta de entrada no-custodial a ETH y USDC.';

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
  String get copiedToClipboard => 'Dirección copiada al portapapeles';

  @override
  String get copyTooltip => 'Copiar dirección';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get sendButton => 'Enviar';

  @override
  String get receiveButton => 'Recibir';

  @override
  String get sendTitle => 'Enviar';

  @override
  String get networkLabel => 'Red';

  @override
  String get addressHint => 'Dirección Destino';

  @override
  String get amountHint => 'Monto';

  @override
  String get maxButton => 'MÁX';

  @override
  String get sendAction => 'Enviar';

  @override
  String get themeToggleTooltip => 'Cambiar tema';

  @override
  String get networkTab => 'Redes';

  @override
  String get stableTab => 'Monedas';

  @override
  String get noStableFound => 'No se encontraron monedas';

  @override
  String get allNetworksFilter => 'Todas';

  @override
  String get swapButton => 'Intercambiar';

  @override
  String get buyButton => 'Comprar';

  @override
  String get faucetButton => 'Faucet';

  @override
  String get faucetTitle => 'Faucets de Testnet';

  @override
  String get faucetSubtitle =>
      'Obtén tokens de prueba gratis para probar la wallet';

  @override
  String get searchTokenHint => 'Buscar token...';

  @override
  String get assetLabel => 'Activo';

  @override
  String get nativeAsset => 'Nativo';

  @override
  String get errorEmptyAddress => 'La dirección no puede estar vacía';

  @override
  String get errorInvalidAddress => 'Dirección inválida';

  @override
  String get errorInvalidAmount => 'El monto debe ser mayor a cero';

  @override
  String get errorInsufficientBalance => 'Saldo insuficiente';

  @override
  String get errorLoadWallet => 'Error al cargar la billetera';

  @override
  String get txSentSuccess => '¡Transacción enviada!';

  @override
  String get tokenDetailTitle => 'Detalles del Token';

  @override
  String get contractAddressLabel => 'Dirección del Contrato';

  @override
  String get viewOnExplorer => 'Ver en Explorador';

  @override
  String get contractCopied => 'Dirección del contrato copiada';

  @override
  String get estimatedFeeLabel => 'Comisión estimada';

  @override
  String get estimatingFee => 'Estimando comisión...';

  @override
  String get confirmSendTitle => 'Confirmar Transacción';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get confirmButton => 'Confirmar';
}
