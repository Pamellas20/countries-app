import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import '../utils/error_formatter.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formattedMessage = formatErrorMessage(message);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: isDark ? Colors.red[300] : Colors.red[700],
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: isDark
                  ? AppTextStyles.darkCountryName
                  : AppTextStyles.lightCountryName,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              formattedMessage,
              style: isDark
                  ? AppTextStyles.darkPopulation
                  : AppTextStyles.lightPopulation,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
