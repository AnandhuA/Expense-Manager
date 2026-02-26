import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LimitCardWidget extends StatelessWidget {
  const LimitCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is! ProfileLoaded) {
          return const SizedBox();
        }

        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            if (dashboardState is! DashboardLoaded) {
              return const SizedBox();
            }

            final double limit = profileState.alertLimit;
            final double expense = dashboardState.totalExpense;

            final double progress =
                limit == 0 ? 0 : (expense / limit).clamp(0, 1);

            final double remaining =
                (limit - expense).clamp(0, limit);

            final int remainingPercent =
                ((remaining / limit) * 100).round();

            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.limitCardBg,
                border: Border.all(
                  color: AppColors.limitCardBoder,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "MONTHLY LIMIT",
                    style: TextStyle(color: AppColors.textHint),
                  ),

                  AppSpacing.hBox10,

                  Text(
                    "₹${expense.toStringAsFixed(0)} / ₹${limit.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  AppSpacing.hBox10,

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.progressBarBgColor,
                    color: progress >= 1
                        ? Colors.red
                        : AppColors.progressBarColor,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  AppSpacing.hBox10,

                  Text(
                    progress >= 1
                        ? "Limit exceeded"
                        : "$remainingPercent% Remaining",
                    style: const TextStyle(color: AppColors.textHint),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}