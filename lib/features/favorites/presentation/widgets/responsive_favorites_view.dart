import 'package:flutter/material.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../home/domain/entities/country_summary.dart';
import 'favorite_country_item.dart';
import 'favorite_grid_item.dart';

class ResponsiveFavoritesView extends StatelessWidget {
  final List<CountrySummary> favorites;
  final Function(CountrySummary) onCountryTap;
  final Function(CountrySummary) onRemoveFavorite;

  const ResponsiveFavoritesView({
    super.key,
    required this.favorites,
    required this.onCountryTap,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = Breakpoints.getScreenType(constraints.maxWidth);

        if (screenType == ScreenType.mobile) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final country = favorites[index];
              return FavoriteCountryItem(
                country: country,
                onTap: () => onCountryTap(country),
                onRemove: () => onRemoveFavorite(country),
              );
            },
          );
        }
        int crossAxisCount;
        double childAspectRatio;
        double spacing;

        if (screenType == ScreenType.desktop) {
          crossAxisCount = 4;
          childAspectRatio = 0.75;
          spacing = 24;
        } else {
          crossAxisCount = 2;
          childAspectRatio = 0.8;
          spacing = 16;
        }

        return GridView.builder(
          padding: EdgeInsets.all(spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final country = favorites[index];
            return FavoriteGridItem(
              country: country,
              onTap: () => onCountryTap(country),
              onRemove: () => onRemoveFavorite(country),
            );
          },
        );
      },
    );
  }
}
