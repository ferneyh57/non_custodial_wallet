import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
    filter: ProductionFilter(),
  );

  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(_redact(message), error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(_redact(message), error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(_redact(message), error: error, stackTrace: stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(_redact(message), error: error, stackTrace: stackTrace);
  }

  /// Redacts sensitive information like mnemonics or private keys from logs.
  static String _redact(String message) {
    if (kReleaseMode) {
      // In release mode, we could be even more aggressive.
      // For now, let's just do basic keyword-based redaction.
    }

    // Example: Redact patterns that look like 12-word mnemonics or hex keys
    // This is a simplified version; real-world apps should be very careful.
    final redactedMessage = message
        .replaceAll(
          RegExp(r'\b(?:[a-z]{3,}\s){11,}[a-z]{3,}\b'),
          '[MNEMONIC REDACTED]',
        )
        .replaceAll(RegExp(r'\b[0-9a-fA-F]{64}\b'), '[PRIVATE KEY REDACTED]');

    return redactedMessage;
  }
}

class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    }
    return true;
  }
}
