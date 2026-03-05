import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Text(
      title,
      style: isDark ? AppTextStyles.darkHeader : AppTextStyles.lightHeader,
    );
  }
}