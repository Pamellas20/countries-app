import 'package:flutter/material.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../domain/entities/country_summary.dart';
import 'country_list_item.dart';
import 'country_grid_item.dart';
import 'country_list_item_shimmer.dart';

class ResponsiveCountryView extends StatefulWidget {
  const ResponsiveCountryView({
    super.key,
    required this.countries,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.onCountryTap,
    this.onLoadMore,
  });

  final List<CountrySummary> countries;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final ValueChanged<CountrySummary>? onCountryTap;
  final VoidCallback? onLoadMore;

  @override
  State<ResponsiveCountryView> createState() => _ResponsiveCountryViewState();
}

class _ResponsiveCountryViewState extends State<ResponsiveCountryView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !widget.isLoadingMore && !widget.hasReachedMax) {
      widget.onLoadMore?.call();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  int _getCrossAxisCount(double width) {
    if (Breakpoints.isMobile(width)) return 1;
    if (Breakpoints.isTablet(width)) return 2;
    return 4; // Desktop: 4 columns
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        final isMobile = Breakpoints.isMobile(constraints.maxWidth);

        if (widget.isLoading) {
          return isMobile
              ? ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      const CountryListItemShimmer(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      const CountryListItemShimmer(),
                );
        }

        final itemCount = widget.hasReachedMax
            ? widget.countries.length
            : widget.countries.length + 1;

        // Mobile: List view
        if (isMobile) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index >= widget.countries.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final country = widget.countries[index];
              return CountryListItem(
                country: country,
                onTap: () => widget.onCountryTap?.call(country),
              );
            },
          );
        }

        // Tablet & Desktop: Grid view
        return GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index >= widget.countries.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final country = widget.countries[index];
            return CountryGridItem(
              country: country,
              onTap: () => widget.onCountryTap?.call(country),
            );
          },
        );
      },
    );
  }
}
