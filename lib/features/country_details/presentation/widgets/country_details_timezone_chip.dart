import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CountryDetailsTimezoneChip extends StatelessWidget {
  const CountryDetailsTimezoneChip({super.key, required this.timezone});

  final String timezone;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark
              ? AppColors.darkPrimaryText
              : AppColors.lightSecondaryText,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        timezone,
        style: isDark
            ? AppTextStyles.darkSubHeader
            : AppTextStyles.lightSubHeader,
      ),
    );
  }
}
