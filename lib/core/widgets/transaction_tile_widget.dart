import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionTileWidget extends StatelessWidget {
  final String title;
  final String category;
  final DateTime date;
  final double amount;
  final bool isCredit;
  final VoidCallback? onDelete;
  const TransactionTileWidget({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.isCredit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.shadow,
        border: Border.all(color: AppColors.boderColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          /// Leading Icon
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.shadow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),

          const SizedBox(width: 12),

          /// Title + Category
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(fontSize: 13, color: AppColors.textHint),
                ),
              ],
            ),
          ),

          /// Date + Amount + Delete
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${date.day} ${Formatters.monthName(date.month)} ${date.year}",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 4),
              Text(
                "${isCredit ? '+' : '-'}₹${amount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCredit ? AppColors.creditText : AppColors.debitText,
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),

          IconButton(
            onPressed: onDelete,
            icon: SvgPicture.asset(AppAssets.deleteIcon),
          ),
        ],
      ),
    );
  }
}
