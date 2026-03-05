import 'package:countries_app/core/network/network_exceptions.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._localDataSource);

  final FavoritesLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<CountrySummary>>> getFavorites() async {
    try {
      final favorites = await _localDataSource.getFavoriteCountries();
      return Right(favorites);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to load favorites: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String cca2) async {
    try {
      final isFav = await _localDataSource.isFavorite(cca2);
      if (isFav) {
        await _localDataSource.removeFavorite(cca2);
      } else {
        await _localDataSource.addFavorite(cca2);
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to toggle favorite: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String cca2) async {
    try {
      final isFav = await _localDataSource.isFavorite(cca2);
      return Right(isFav);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to check favorite status: $e'));
    }
  }
}
