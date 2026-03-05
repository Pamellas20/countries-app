import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/population_formatter.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../domain/entities/country_details.dart';
import '../cubit/country_details_cubit.dart';
import '../cubit/country_details_state.dart';
import '../widgets/country_details_shimmer.dart';
import '../widgets/country_details_header.dart';
import '../widgets/country_details_section.dart';
import '../widgets/country_details_stat_row.dart';
import '../widgets/country_details_timezone_chip.dart';

class CountryDetailsPage extends StatelessWidget {
  const CountryDetailsPage({super.key, required this.cca2});

  final String cca2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CountryDetailsCubit>()..loadCountryDetails(cca2),
      child: const _CountryDetailsPageContent(),
    );
  }
}

class _CountryDetailsPageContent extends StatelessWidget {
  const _CountryDetailsPageContent();

  String _formatArea(double area) {
    return '${area.toStringAsFixed(0)} sq km';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: BlocBuilder<CountryDetailsCubit, CountryDetailsState>(
        builder: (context, state) {
          if (state is CountryDetailsLoading) {
            return const CountryDetailsShimmer();
          }

          if (state is CountryDetailsLoaded) {
            final country = state.countryDetails;

            return ResponsiveLayout(
              mobile: _buildMobileLayout(country),
              tablet: _buildTabletLayout(country),
              desktop: _buildDesktopLayout(country),
            );
          }

          if (state is CountryDetailsError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Country Details')),
              body: AppErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<CountryDetailsCubit>().loadCountryDetails(
                      ModalRoute.of(context)?.settings.arguments as String,
                    ),
              ),
            );
          }

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(CountryDetails country) {
    return CustomScrollView(
      slivers: [
        CountryDetailsHeader(countryName: country.name, flagUrl: country.flag),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildDetailsContent(country),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(CountryDetails country) {
    return CustomScrollView(
      slivers: [
        CountryDetailsHeader(
          countryName: country.name,
          flagUrl: country.flag,
          expandedHeight: 300,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildDetailsContent(country)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(CountryDetails country) {
    return CustomScrollView(
      slivers: [
        CountryDetailsHeader(
          countryName: country.name,
          flagUrl: country.flag,
          expandedHeight: 400,
        ),
        SliverToBoxAdapter(
          child: MaxWidthContainer(
            maxWidth: 1200,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: _buildDetailsContent(country),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsContent(CountryDetails country) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountryDetailsSection(
          title: 'Key Statistics',
          children: [
            CountryDetailsStatRow(
              label: 'Area',
              value: _formatArea(country.area),
            ),
            CountryDetailsStatRow(
              label: 'Population',
              value: formatPopulation(country.population),
            ),
            CountryDetailsStatRow(label: 'Region', value: country.region),
            CountryDetailsStatRow(
              label: 'Sub Region',
              value: country.subregion,
            ),
          ],
        ),
        const SizedBox(height: 32),
        CountryDetailsSection(
          title: 'Timezone',
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: country.timezones
                  .map<Widget>(
                    (timezone) =>
                        CountryDetailsTimezoneChip(timezone: timezone),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
