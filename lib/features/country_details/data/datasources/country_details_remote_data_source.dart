import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/error/failure.dart';
import '../models/country_details_model.dart';

abstract class CountryDetailsRemoteDataSource {
  Future<CountryDetailsModel> getCountryDetails(String cca2);
}

class CountryDetailsRemoteDataSourceImpl
    implements CountryDetailsRemoteDataSource {
  const CountryDetailsRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<CountryDetailsModel> getCountryDetails(String cca2) async {
    final response = await _dioClient.get(
      ApiEndpoints.getCountryByCode(cca2),
      queryParameters: ApiEndpoints.countryDetailFields,
    );

    final dynamic data = response.data;
    if (data is List && data.isNotEmpty) {
      return CountryDetailsModel.fromJson(data.first);
    } else if (data is Map<String, dynamic>) {
      return CountryDetailsModel.fromJson(data);
    } else {
      throw ClientFailure('Invalid response format');
    }
  }
}
