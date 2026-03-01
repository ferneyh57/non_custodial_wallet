import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFF00B4DB),
      onPrimary: Colors.white,
      secondary: Color(0xFF2EBD85),
      onSecondary: Colors.white,
      surface: Color(0xFF0F2027),
      onSurface: Colors.white,
      surfaceContainerHighest: Color(0xFF1E2A32),
      outline: Color(0x1FFFFFFF),
      error: Color(0xFFCF6679),
      onError: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF0F2027),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x0DFFFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.poppins(color: const Color(0x61FFFFFF)),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension.dark,
      ],
    );
  }

  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF0083B0),
      onPrimary: Colors.white,
      secondary: Color(0xFF1E9B6B),
      onSecondary: Colors.white,
      surface: Color(0xFFF5F7FA),
      onSurface: Color(0xFF1A1A2E),
      surfaceContainerHighest: Color(0xFFFFFFFF),
      outline: Color(0xFFDDE1E6),
      error: Color(0xFFB00020),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: const Color(0xFF1A1A2E),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1A1A2E)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFEEF0F3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension.light,
      ],
    );
  }
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color balanceCardGradientStart;
  final Color balanceCardGradientEnd;
  final Color backgroundGradientStart;
  final Color backgroundGradientMid;
  final Color backgroundGradientEnd;
  final Color containerFill;
  final Color subtitleText;
  final Color hintText;
  final Color dividerColor;
  final Color cardColor;
  final Color cardBorder;

  const AppThemeExtension({
    required this.balanceCardGradientStart,
    required this.balanceCardGradientEnd,
    required this.backgroundGradientStart,
    required this.backgroundGradientMid,
    required this.backgroundGradientEnd,
    required this.containerFill,
    required this.subtitleText,
    required this.hintText,
    required this.dividerColor,
    required this.cardColor,
    required this.cardBorder,
  });

  static const dark = AppThemeExtension(
    balanceCardGradientStart: Color(0xFF0ED2F7),
    balanceCardGradientEnd: Color(0xFF005C97),
    backgroundGradientStart: Color(0xFF0F2027),
    backgroundGradientMid: Color(0xFF203A43),
    backgroundGradientEnd: Color(0xFF2C5364),
    containerFill: Color(0x0DFFFFFF),
    subtitleText: Color(0xB3FFFFFF),
    hintText: Color(0x61FFFFFF),
    dividerColor: Color(0x1AFFFFFF),
    cardColor: Color(0xFF162530),
    cardBorder: Color(0x1AFFFFFF),
  );

  static const light = AppThemeExtension(
    balanceCardGradientStart: Color(0xFF0ED2F7),
    balanceCardGradientEnd: Color(0xFF005C97),
    backgroundGradientStart: Color(0xFFE8F4F8),
    backgroundGradientMid: Color(0xFFD4E8EF),
    backgroundGradientEnd: Color(0xFFC0DCE5),
    containerFill: Color(0xFFEEF0F3),
    subtitleText: Color(0xFF6B7280),
    hintText: Color(0xFF9CA3AF),
    dividerColor: Color(0xFFDDE1E6),
    cardColor: Color(0xFFFFFFFF),
    cardBorder: Color(0xFFE5E7EB),
  );

  @override
  AppThemeExtension copyWith({
    Color? balanceCardGradientStart,
    Color? balanceCardGradientEnd,
    Color? backgroundGradientStart,
    Color? backgroundGradientMid,
    Color? backgroundGradientEnd,
    Color? containerFill,
    Color? subtitleText,
    Color? hintText,
    Color? dividerColor,
    Color? cardColor,
    Color? cardBorder,
  }) {
    return AppThemeExtension(
      balanceCardGradientStart:
          balanceCardGradientStart ?? this.balanceCardGradientStart,
      balanceCardGradientEnd:
          balanceCardGradientEnd ?? this.balanceCardGradientEnd,
      backgroundGradientStart:
          backgroundGradientStart ?? this.backgroundGradientStart,
      backgroundGradientMid:
          backgroundGradientMid ?? this.backgroundGradientMid,
      backgroundGradientEnd:
          backgroundGradientEnd ?? this.backgroundGradientEnd,
      containerFill: containerFill ?? this.containerFill,
      subtitleText: subtitleText ?? this.subtitleText,
      hintText: hintText ?? this.hintText,
      dividerColor: dividerColor ?? this.dividerColor,
      cardColor: cardColor ?? this.cardColor,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      balanceCardGradientStart: Color.lerp(
          balanceCardGradientStart, other.balanceCardGradientStart, t)!,
      balanceCardGradientEnd:
          Color.lerp(balanceCardGradientEnd, other.balanceCardGradientEnd, t)!,
      backgroundGradientStart: Color.lerp(
          backgroundGradientStart, other.backgroundGradientStart, t)!,
      backgroundGradientMid:
          Color.lerp(backgroundGradientMid, other.backgroundGradientMid, t)!,
      backgroundGradientEnd:
          Color.lerp(backgroundGradientEnd, other.backgroundGradientEnd, t)!,
      containerFill: Color.lerp(containerFill, other.containerFill, t)!,
      subtitleText: Color.lerp(subtitleText, other.subtitleText, t)!,
      hintText: Color.lerp(hintText, other.hintText, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
    );
  }
}
