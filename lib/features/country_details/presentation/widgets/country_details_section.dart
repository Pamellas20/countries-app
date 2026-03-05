import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class CountryDetailsSection extends StatelessWidget {
  const CountryDetailsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isDark ? AppTextStyles.darkHeader : AppTextStyles.lightHeader,
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
