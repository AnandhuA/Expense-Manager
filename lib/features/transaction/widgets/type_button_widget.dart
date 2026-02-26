import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TypeButtonWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const TypeButtonWidget({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            color: selected ? AppColors.green : AppColors.shadow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
