import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CountryDetailsHeader extends StatelessWidget {
  const CountryDetailsHeader({
    super.key,
    required this.countryName,
    required this.flagUrl,
    this.expandedHeight = 300,
  });

  final String countryName;
  final String flagUrl;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: isDark
              ? AppColors.darkPrimaryText
              : AppColors.lightPrimaryText,
        ),
      ),
      title: Text(
        countryName,
        style: isDark ? AppTextStyles.darkHeader : AppTextStyles.lightHeader,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(top: 100, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(flagUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
