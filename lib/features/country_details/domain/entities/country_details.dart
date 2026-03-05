import 'package:equatable/equatable.dart';

class CountryDetails extends Equatable {
  const CountryDetails({
    required this.name,
    required this.flag,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
    required this.cca2,
  });

  final String name;
  final String flag;
  final int population;
  final List<String> capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;
  final String cca2;

  @override
  List<Object> get props => [
        name,
        flag,
        population,
        capital,
        region,
        subregion,
        area,
        timezones,
        cca2,
      ];
}