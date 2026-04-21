import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color tokens mirror the Ledger web app (HSL → hex).
class AppColors {
  static const Color background = Color(0xFFF7F4ED); // warm paper
  static const Color foreground = Color(0xFF0D2620); // deep dark green
  static const Color card = Color(0xFFFBFAF5);
  static const Color border = Color(0xFFD1DDD8);
  static const Color primary = Color(0xFF1A4D40); // deep forest
  static const Color primaryFg = Color(0xFFFBFAF5);
  static const Color secondary = Color(0xFFD1DDD8); // soft sage
  static const Color muted = Color(0xFFE2E8E4);
  static const Color mutedFg = Color(0xFF62847A);
  static const Color destructive = Color(0xFFB85136);
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        surface: AppColors.background,
        primary: AppColors.primary,
        onPrimary: AppColors.primaryFg,
        secondary: AppColors.secondary,
        onSecondary: AppColors.primary,
        error: AppColors.destructive,
        onError: AppColors.primaryFg,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.foreground,
        displayColor: AppColors.foreground,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryFg,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  static TextStyle serif({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.foreground,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.1,
    );
  }

  static TextStyle mono({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.mutedFg,
    double letterSpacing = 1.2,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
