import 'package:flutter/material.dart';
import '../../domain/entities/country_summary.dart';
import 'country_list_item.dart';
import 'country_list_item_shimmer.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({
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
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
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

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const CountryListItemShimmer(),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hasReachedMax
          ? widget.countries.length
          : widget.countries.length + 1,
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
}
