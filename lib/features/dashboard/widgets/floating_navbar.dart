import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      left: MQ.w(context, 20),
      right: MQ.w(context, 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.navBarBg,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color: AppColors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(
              icon: AppAssets.homeIcon,
              index: 0,
              isActive: currentIndex == 0,
              onTap: onTap,
            ),

            _item(
              icon: AppAssets.syncIcon,
              index: 1,
              isActive: currentIndex == 1,
              onTap: onTap,
            ),

            _item(
              icon: AppAssets.profileIcon,
              index: 2,
              isActive: currentIndex == 2,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required String icon,
    required int index,
    required bool isActive,
    required Function(int) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: isActive
            ? BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)
            : null,
        child: SvgPicture.asset(
          icon,
          width: 22,
          height: 22,
          colorFilter: ColorFilter.mode(
          AppColors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
