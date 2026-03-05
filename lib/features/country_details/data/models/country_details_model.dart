import '../../domain/entities/country_details.dart';

class CountryDetailsModel extends CountryDetails {
  const CountryDetailsModel({
    required super.name,
    required super.flag,
    required super.population,
    required super.capital,
    required super.region,
    required super.subregion,
    required super.area,
    required super.timezones,
    required super.cca2,
  });

  factory CountryDetailsModel.fromJson(Map<String, dynamic> json) {
    return CountryDetailsModel(
      name: json['name']?['common'] as String? ?? 'Unknown',
      flag: json['flags']?['png'] as String? ?? '',
      population: json['population'] as int? ?? 0,
      capital: List<String>.from(json['capital'] ?? []),
      region: json['region'] as String? ?? '',
      subregion: json['subregion'] as String? ?? '',
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      timezones: List<String>.from(json['timezones'] ?? []),
      cca2: json['cca2'] as String? ?? '',
    );
  }
}
