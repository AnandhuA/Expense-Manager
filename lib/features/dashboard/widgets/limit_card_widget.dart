import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class LimitCardWidget extends StatelessWidget {
  const LimitCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.limitCardBg,
        border: Border.all(color: AppColors.limitCardBoder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text("MONTHLY LIMIT", style: TextStyle(color: AppColors.textHint)),
          AppSpacing.hBox10,
          Text("₹7,324/₹10,000"),
          AppSpacing.hBox10,
          LinearProgressIndicator(
            value: 0.73,
            minHeight: 5,
            backgroundColor: AppColors.progressBarBgColor,
            color: AppColors.progressBarColor,
            borderRadius: BorderRadius.circular(10),
          ),
          AppSpacing.hBox10,
          Text("27% Remaining", style: TextStyle(color: AppColors.textHint)),
        ],
      ),
    );
  }
}
