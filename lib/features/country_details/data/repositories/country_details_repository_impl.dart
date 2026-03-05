import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/country_details.dart';
import '../../domain/repositories/country_details_repository.dart';
import '../datasources/country_details_remote_data_source.dart';

class CountryDetailsRepositoryImpl implements CountryDetailsRepository {
  const CountryDetailsRepositoryImpl(this._remoteDataSource);

  final CountryDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, CountryDetails>> getCountryDetails(String cca2) async {
    try {
      final countryDetails = await _remoteDataSource.getCountryDetails(cca2);
      return Right(countryDetails);
    } on Failure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(NetworkException.handleDioException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
