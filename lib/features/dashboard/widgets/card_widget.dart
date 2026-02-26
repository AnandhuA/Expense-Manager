import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String price;
  final bool isIncome;
  const CardWidget({
    super.key,
    required this.title,
    required this.isIncome,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: isIncome ? AppColors.incomeCardBg : AppColors.expenseCardBg,
          width: 0.3,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isIncome
              ? [AppColors.incomeCardBg, AppColors.incomeCardBgDark]
              : [AppColors.expenseCardBg, AppColors.expenseCardBgDark],
        ),

        // color: isIncome ? AppColors.incomeCardBg : AppColors.expenseCardBg,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title),
          AppSpacing.hBox15,
          Row(
            children: [
              Icon(
                isIncome
                    ? Icons.arrow_downward_sharp
                    : Icons.arrow_upward_sharp,
              ),
              AppSpacing.wBox5,
              Text("₹ $price", style: TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
