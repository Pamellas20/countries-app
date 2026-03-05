import 'package:flutter/material.dart';
import '../../../home/domain/entities/country_summary.dart';
import 'favorite_country_item.dart';

class FavoritesListView extends StatelessWidget {
  const FavoritesListView({
    super.key,
    required this.favorites,
    this.onCountryTap,
    this.onRemoveFavorite,
  });

  final List<CountrySummary> favorites;
  final ValueChanged<CountrySummary>? onCountryTap;
  final ValueChanged<CountrySummary>? onRemoveFavorite;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final country = favorites[index];
        return FavoriteCountryItem(
          country: country,
          onTap: () => onCountryTap?.call(country),
          onRemove: () => onRemoveFavorite?.call(country),
        );
      },
    );
  }
}
