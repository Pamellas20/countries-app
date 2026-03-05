import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../network/dio_client.dart';
import '../../features/home/data/datasources/countries_remote_data_source.dart';
import '../../features/home/data/repositories/countries_repository_impl.dart';
import '../../features/home/domain/repositories/countries_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/search_bar_cubit.dart';

import '../../features/country_details/data/datasources/country_details_remote_data_source.dart';
import '../../features/country_details/data/repositories/country_details_repository_impl.dart';
import '../../features/country_details/domain/repositories/country_details_repository.dart';
import '../../features/country_details/presentation/cubit/country_details_cubit.dart';

import '../../features/favorites/data/datasources/favorites_local_data_source.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Load environment variables
  await dotenv.load(fileName: '.env');

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CountryDetailsRemoteDataSource>(
    () => CountryDetailsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CountryDetailsRepository>(
    () => CountryDetailsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => SearchBarCubit());
  sl.registerFactory(() => CountryDetailsCubit(sl(), sl()));
  sl.registerFactory(() => FavoritesCubit(sl()));
}
