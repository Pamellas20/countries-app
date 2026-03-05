import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/country_summary.dart';

class FavoriteGridItem extends StatelessWidget {
  const FavoriteGridItem({
    super.key,
    required this.country,
    this.onTap,
    this.onRemove,
  });

  final CountrySummary country;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: country.flag,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, error, stackTrace) => Container(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText,
                        child: const Icon(Icons.flag, size: 40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Material(
                      color: AppColors.darkBackground.withValues(alpha: 0.5),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onRemove,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.favoriteColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        country.name,
                        style: isDark
                            ? AppTextStyles.darkCountryName
                            : AppTextStyles.lightCountryName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        'Capital: ${country.capital ?? 'N/A'}',
                        style: isDark
                            ? AppTextStyles.darkPopulation
                            : AppTextStyles.lightPopulation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
