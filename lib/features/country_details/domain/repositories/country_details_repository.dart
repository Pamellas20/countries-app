import 'package:countries_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/country_details.dart';

abstract class CountryDetailsRepository {
  Future<Either<Failure, CountryDetails>> getCountryDetails(String cca2);
}
