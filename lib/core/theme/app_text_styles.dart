import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  // Base text styles
  static final TextStyle _countryNameBase = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0,
  );

  static final TextStyle _populationAndKeyStatsBase =
      GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.5,
        letterSpacing: 0,
      );

  static final TextStyle _headerBase = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.28,
    letterSpacing: 0,
  );

  static final TextStyle _subHeaderBase = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0,
  );

  // Light mode text styles
  static final TextStyle lightCountryName = _countryNameBase.copyWith(
    color: AppColors.lightPrimaryText,
  );
  static final TextStyle lightPopulation = _populationAndKeyStatsBase.copyWith(
    color: AppColors.lightSecondaryText,
  );
  static final TextStyle lightHeader = _headerBase.copyWith(
    color: AppColors.lightPrimaryText,
  );
  static final TextStyle lightKeyStatsValue = _populationAndKeyStatsBase
      .copyWith(color: AppColors.lightPrimaryText);

  // Dark mode text styles
  static final TextStyle darkCountryName = _countryNameBase.copyWith(
    color: AppColors.darkPrimaryText,
  );
  static final TextStyle darkPopulation = _populationAndKeyStatsBase.copyWith(
    color: AppColors.darkSecondaryText,
  );
  static final TextStyle darkHeader = _headerBase.copyWith(
    color: AppColors.darkPrimaryText,
  );
  static final TextStyle darkKeyStatsValue = _populationAndKeyStatsBase
      .copyWith(color: AppColors.darkPrimaryText);

  static final TextStyle lightSubHeader = _subHeaderBase.copyWith(
    color: AppColors.lightPrimaryText,
  );
  static final TextStyle darkSubHeader = _subHeaderBase.copyWith(
    color: AppColors.darkPrimaryText,
  );
}
