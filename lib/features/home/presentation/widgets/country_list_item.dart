import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/population_formatter.dart';
import '../../domain/entities/country_summary.dart';
import '../cubit/home_cubit.dart';

class CountryListItem extends StatefulWidget {
  const CountryListItem({super.key, required this.country, this.onTap});

  final CountrySummary country;
  final VoidCallback? onTap;

  @override
  State<CountryListItem> createState() => _CountryListItemState();
}

class _CountryListItemState extends State<CountryListItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favorite = await context.read<HomeCubit>().isFavorite(
      widget.country.cca2,
    );
    setState(() => isFavorite = favorite);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.country.flag,
                width: 85,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 85,
                  height: 48,
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
                    widget.country.name,
                    style: isDark
                        ? AppTextStyles.darkCountryName
                        : AppTextStyles.lightCountryName,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Population: ${formatPopulation(widget.country.population)}',
                    style: isDark
                        ? AppTextStyles.darkPopulation
                        : AppTextStyles.lightPopulation,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<HomeCubit>().toggleFavorite(widget.country.cca2);
                setState(() => isFavorite = !isFavorite);
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? AppColors.favoriteColor
                    : isDark
                    ? AppColors.lightBackground.withValues(alpha: 0.8)
                    : AppColors.darkBackground.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
