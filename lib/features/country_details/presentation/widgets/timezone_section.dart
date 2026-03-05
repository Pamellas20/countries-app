import 'package:flutter/material.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/theme/app_text_styles.dart';

class TimezoneSection extends StatelessWidget {
  const TimezoneSection({
    super.key,
    required this.timezones,
  });

  final List<String> timezones;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Timezone'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timezones.map((timezone) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                timezone,
                style: isDark ? AppTextStyles.darkPopulation : AppTextStyles.lightPopulation,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}