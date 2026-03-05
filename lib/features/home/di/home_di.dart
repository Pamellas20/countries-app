import 'package:get_it/get_it.dart';
import '../data/datasources/countries_remote_data_source.dart';
import '../data/repositories/countries_repository_impl.dart';
import '../domain/repositories/countries_repository.dart';
import '../presentation/cubit/home_cubit.dart';
import '../presentation/cubit/search_bar_cubit.dart';

final sl = GetIt.instance;

void initHomeDependencies() {
  // Data sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => SearchBarCubit());
}
