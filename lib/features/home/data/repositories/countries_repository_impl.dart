import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/country_summary.dart';
import '../../domain/repositories/countries_repository.dart';
import '../datasources/countries_remote_data_source.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  const CountriesRepositoryImpl(this._remoteDataSource);

  final CountriesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<CountrySummary>>> getAllCountries() async {
    try {
      final countries = await _remoteDataSource.getAllCountries();
      return Right(countries);
    } on Failure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CountrySummary>>> searchCountries(
    String query,
  ) async {
    try {
      final countries = await _remoteDataSource.searchCountries(query);
      return Right(countries);
    } on Failure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
