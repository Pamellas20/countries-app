import 'package:get_it/get_it.dart';
import 'core_di.dart';
import '../../features/home/di/home_di.dart';
import '../../features/country_details/di/country_details_di.dart';
import '../../features/favorites/di/favorites_di.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize core dependencies (SharedPreferences, DioClient, ThemeCubit)
  await initCoreDependencies();

  // Initialize feature-specific dependencies
  initHomeDependencies();
  initCountryDetailsDependencies();
  initFavoritesDependencies();
}
