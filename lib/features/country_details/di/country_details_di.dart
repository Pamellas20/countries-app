import 'package:get_it/get_it.dart';
import '../data/datasources/country_details_remote_data_source.dart';
import '../data/repositories/country_details_repository_impl.dart';
import '../domain/repositories/country_details_repository.dart';
import '../presentation/cubit/country_details_cubit.dart';

final sl = GetIt.instance;

void initCountryDetailsDependencies() {
  // Data sources
  sl.registerLazySingleton<CountryDetailsRemoteDataSource>(
    () => CountryDetailsRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<CountryDetailsRepository>(
    () => CountryDetailsRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => CountryDetailsCubit(sl(), sl()));
}
