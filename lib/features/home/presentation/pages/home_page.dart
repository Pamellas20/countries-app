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
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../cubit/search_bar_cubit.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/responsive_country_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeCubit>()..loadCountries()),
        BlocProvider(create: (_) => sl<SearchBarCubit>()),
      ],
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Countries',
          style: isDark ? AppTextStyles.darkHeader : AppTextStyles.lightHeader,
        ),
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        centerTitle: true,
        elevation: 0,
      ),
      body: MaxWidthContainer(
        child: Column(
          children: [
            HomeSearchBar(
              onChanged: (query) {
                context.read<HomeCubit>().searchCountries(query);
              },
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const ResponsiveCountryView(
                      countries: [],
                      isLoading: true,
                    );
                  }

                  if (state is HomeLoaded) {
                    return ResponsiveCountryView(
                      countries: state.countries,
                      isLoadingMore: state.isLoadingMore,
                      hasReachedMax: state.hasReachedMax,
                      onCountryTap: (country) {
                        context.push(
                          AppRouter.countryDetailsPath(country.cca2),
                        );
                      },
                      onLoadMore: () {
                        context.read<HomeCubit>().loadMoreCountries();
                      },
                    );
                  }

                  if (state is HomeEmpty) {
                    return const AppEmptyView(
                      message: 'No countries found',
                      icon: Icons.search_off,
                    );
                  }

                  if (state is HomeError) {
                    return AppErrorView(
                      message: state.message,
                      onRetry: () => context.read<HomeCubit>().loadCountries(),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
