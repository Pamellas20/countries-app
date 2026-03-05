import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../network/dio_client.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initCoreDependencies() async {
  // Load environment variables
  await dotenv.load(fileName: '.env');

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Theme
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
}
