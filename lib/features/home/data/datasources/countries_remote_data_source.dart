import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/country_summary_model.dart';

abstract class CountriesRemoteDataSource {
  Future<List<CountrySummaryModel>> getAllCountries();
  Future<List<CountrySummaryModel>> searchCountries(String query);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  const CountriesRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<CountrySummaryModel>> getAllCountries() async {
    final response = await _dioClient.get(
      ApiEndpoints.getAllCountries,
      queryParameters: ApiEndpoints.countrySummaryFields,
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => CountrySummaryModel.fromJson(json)).toList();
  }

  @override
  Future<List<CountrySummaryModel>> searchCountries(String query) async {
    final response = await _dioClient.get(
      ApiEndpoints.getCountryByName(query),
      queryParameters: ApiEndpoints.countrySummaryFields,
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => CountrySummaryModel.fromJson(json)).toList();
  }
}