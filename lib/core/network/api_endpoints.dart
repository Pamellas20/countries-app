class ApiEndpoints {
  const ApiEndpoints._();

  // Endpoints
  static const String getAllCountries = '/all';
  static String getCountryByName(String name) => '/name/$name';
  static String getCountryByCode(String code) => '/alpha/$code';

  // Query parameters for two-step fetching
  static const Map<String, String> countrySummaryFields = {
    'fields': 'name,flags,population,cca2,capital',
  };

  static const Map<String, String> countryDetailFields = {
    'fields': 'name,flags,population,capital,region,subregion,area,timezones',
  };
}
