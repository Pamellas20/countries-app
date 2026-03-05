import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../widgets/responsive_favorites_view.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritesCubit>()..loadFavorites(),
      child: const _FavoritesPageContent(),
    );
  }
}

class _FavoritesPageContent extends StatelessWidget {
  const _FavoritesPageContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        title: Text(
          'Favorites',
          style: isDark ? AppTextStyles.darkHeader : AppTextStyles.lightHeader,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesLoaded) {
            return MaxWidthContainer(
              child: ResponsiveFavoritesView(
                favorites: state.favorites,
                onCountryTap: (country) {
                  context.push(AppRouter.countryDetailsPath(country.cca2));
                },
                onRemoveFavorite: (country) {
                  context.read<FavoritesCubit>().removeFavorite(country.cca2);
                },
              ),
            );
          }

          if (state is FavoritesEmpty) {
            return const AppEmptyView(
              message: 'No favorite countries yet',
              icon: Icons.favorite_border,
            );
          }

          if (state is FavoritesError) {
            return AppErrorView(
              message: state.message,
              onRetry: () => context.read<FavoritesCubit>().loadFavorites(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
