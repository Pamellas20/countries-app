import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/country_summary.dart';

class FavoriteCountryItem extends StatelessWidget {
  const FavoriteCountryItem({
    super.key,
    required this.country,
    this.onRemove,
    this.onTap,
  });

  final CountrySummary country;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                country.flag,
                width: 85,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 40,
                  color: Colors.grey[300],
                  child: const Icon(Icons.flag),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: isDark
                        ? AppTextStyles.darkCountryName
                        : AppTextStyles.lightCountryName,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Capital: ${country.capital ?? 'N/A'}',
                    style: isDark
                        ? AppTextStyles.darkPopulation
                        : AppTextStyles.lightPopulation,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                onRemove?.call();
              },
              icon: const Icon(Icons.favorite, color: AppColors.favoriteColor),
            ),
          ],
        ),
      ),
    );
  }
}
