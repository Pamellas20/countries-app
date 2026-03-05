import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/search_bar_cubit.dart';
import '../cubit/search_bar_state.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<SearchBarCubit, SearchBarState>(
      listener: (context, state) {
        if (state.query.isEmpty && _controller.text.isNotEmpty) {
          _controller.clear();
        }
      },
      child: BlocBuilder<SearchBarCubit, SearchBarState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSecondaryText.withValues(alpha: 0.1)
                  : AppColors.lightSecondaryText.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                context.read<SearchBarCubit>().updateQuery(value);
                widget.onChanged(value);
              },
              style: isDark
                  ? AppTextStyles.darkPopulation
                  : AppTextStyles.lightPopulation,
              decoration: InputDecoration(
                hintText: 'Search for a country',
                hintStyle: isDark
                    ? AppTextStyles.darkPopulation
                    : AppTextStyles.lightPopulation,
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText,
                ),
                suffixIcon: state.hasText
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                        onPressed: () {
                          context.read<SearchBarCubit>().clearQuery();
                          widget.onChanged('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
