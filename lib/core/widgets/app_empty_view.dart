import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    required this.message,
    this.icon,
  });

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: isDark ? AppTextStyles.darkPopulation.color : AppTextStyles.lightPopulation.color,
              ),
              const SizedBox(height: 16),
            ],
            Text(
              message,
              style: isDark ? AppTextStyles.darkPopulation : AppTextStyles.lightPopulation,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}