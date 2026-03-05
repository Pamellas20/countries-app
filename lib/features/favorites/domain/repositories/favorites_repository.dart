import 'package:countries_app/core/error/failure.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:dartz/dartz.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<CountrySummary>>> getFavorites();
  Future<Either<Failure, void>> toggleFavorite(String cca2);
  Future<Either<Failure, bool>> isFavorite(String cca2);
}
