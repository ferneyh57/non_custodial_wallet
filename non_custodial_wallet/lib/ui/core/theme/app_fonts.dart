import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized font configuration.
///
/// To change the app font, only modify the methods in this class.
class AppFonts {
  AppFonts._();

  /// Creates a [TextStyle] with the app font applied.
  static TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Returns a [TextTheme] with the app font applied.
  static TextTheme textTheme([TextTheme? base]) {
    return GoogleFonts.spaceGroteskTextTheme(base);
  }
}
