import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/main_navigation.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/country_details/presentation/pages/country_details_page.dart';

abstract final class AppRouter {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String countryDetails = '/country-details/:cca2';

  static String countryDetailsPath(String cca2) => '/country-details/$cca2';

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: favorites,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FavoritesPage()),
          ),
        ],
      ),
      GoRoute(
        path: countryDetails,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final cca2 = state.pathParameters['cca2'] ?? '';
          return MaterialPage(child: CountryDetailsPage(cca2: cca2));
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
}
