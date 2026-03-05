import 'package:countries_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/country_summary.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<CountrySummary>>> getAllCountries();
  Future<Either<Failure, List<CountrySummary>>> searchCountries(String query);
}
