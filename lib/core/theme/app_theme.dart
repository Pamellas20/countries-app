import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static final String? _fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: _fontFamily,
      textTheme: TextTheme(
        headlineSmall: AppTextStyles.lightHeader,
        titleMedium: AppTextStyles.lightCountryName,
        bodyMedium: AppTextStyles.lightPopulation,
        bodySmall: AppTextStyles.lightKeyStatsValue,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: _fontFamily,
      textTheme: TextTheme(
        headlineSmall: AppTextStyles.darkHeader,
        titleMedium: AppTextStyles.darkCountryName,
        bodyMedium: AppTextStyles.darkPopulation,
        bodySmall: AppTextStyles.darkKeyStatsValue,
      ),
    );
  }
}
