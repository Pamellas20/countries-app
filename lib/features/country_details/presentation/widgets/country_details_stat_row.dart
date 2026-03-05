import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class CountryDetailsStatRow extends StatelessWidget {
  const CountryDetailsStatRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isDark
                ? AppTextStyles.darkPopulation
                : AppTextStyles.lightPopulation,
          ),
          Flexible(
            child: Text(
              value,
              style: isDark
                  ? AppTextStyles.darkKeyStatsValue
                  : AppTextStyles.lightKeyStatsValue,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
