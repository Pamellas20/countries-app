import 'package:get_it/get_it.dart';
import '../data/datasources/favorites_local_data_source.dart';
import '../data/repositories/favorites_repository_impl.dart';
import '../domain/repositories/favorites_repository.dart';
import '../presentation/cubit/favorites_cubit.dart';

final sl = GetIt.instance;

void initFavoritesDependencies() {
  // Data sources
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => FavoritesCubit(sl()));
}
