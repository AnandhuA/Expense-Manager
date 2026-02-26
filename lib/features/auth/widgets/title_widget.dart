import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        AppSpacing.hBox5,
        Text(subtitle, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
