import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/data/datasources/countries_remote_data_source.dart';
import '../../../home/data/models/country_summary_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<String>> getFavoriteIds();
  Future<void> addFavorite(String cca2);
  Future<void> removeFavorite(String cca2);
  Future<bool> isFavorite(String cca2);
  Future<List<CountrySummaryModel>> getFavoriteCountries();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  const FavoritesLocalDataSourceImpl(this._prefs, this._countriesDataSource);

  final SharedPreferences _prefs;
  final CountriesRemoteDataSource _countriesDataSource;
  static const String _favoritesKey = 'favorites';

  @override
  Future<List<String>> getFavoriteIds() async {
    return _prefs.getStringList(_favoritesKey) ?? [];
  }

  @override
  Future<void> addFavorite(String cca2) async {
    final favorites = await getFavoriteIds();
    if (!favorites.contains(cca2)) {
      favorites.add(cca2);
      await _prefs.setStringList(_favoritesKey, favorites);
    }
  }

  @override
  Future<void> removeFavorite(String cca2) async {
    final favorites = await getFavoriteIds();
    favorites.remove(cca2);
    await _prefs.setStringList(_favoritesKey, favorites);
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    final favorites = await getFavoriteIds();
    return favorites.contains(cca2);
  }

  @override
  Future<List<CountrySummaryModel>> getFavoriteCountries() async {
    final favoriteIds = await getFavoriteIds();
    if (favoriteIds.isEmpty) return [];

    final allCountries = await _countriesDataSource.getAllCountries();
    return allCountries
        .where((country) => favoriteIds.contains(country.cca2))
        .toList();
  }
}
