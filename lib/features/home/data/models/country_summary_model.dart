import '../../domain/entities/country_summary.dart';

class CountrySummaryModel extends CountrySummary {
  const CountrySummaryModel({
    required super.name,
    required super.flag,
    required super.population,
    required super.cca2,
    super.capital,
  });

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    final capitalList = json['capital'] as List<dynamic>?;
    final capital = capitalList?.isNotEmpty == true
        ? capitalList!.first as String
        : null;

    return CountrySummaryModel(
      name: json['name']['common'] as String,
      flag: json['flags']['png'] as String,
      population: json['population'] as int,
      cca2: json['cca2'] as String,
      capital: capital,
    );
  }
}
