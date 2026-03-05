import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'breakpoints.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({super.key, required this.child});

  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRouter.favorites)) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.favorites);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedIndex = _calculateSelectedIndex(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = Breakpoints.getScreenType(constraints.maxWidth);

        // Mobile: Bottom Navigation
        if (screenType == ScreenType.mobile) {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: isDark
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
              currentIndex: selectedIndex,
              onTap: (index) => _onItemTapped(context, index),
              selectedItemColor: isDark
                  ? AppColors.darkPrimaryText
                  : AppColors.lightPrimaryText,
              unselectedItemColor: isDark
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: 'Favorites',
                ),
              ],
            ),
          );
        }

        // Tablet & Desktop: Navigation Rail
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) => _onItemTapped(context, index),
                backgroundColor: isDark
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                selectedIconTheme: IconThemeData(
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText,
                ),
                unselectedIconTheme: IconThemeData(
                  color: isDark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText,
                ),
                selectedLabelTextStyle: TextStyle(
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText,
                ),
                unselectedLabelTextStyle: TextStyle(
                  color: isDark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText,
                ),
                labelType: screenType == ScreenType.desktop
                    ? NavigationRailLabelType.all
                    : NavigationRailLabelType.selected,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
