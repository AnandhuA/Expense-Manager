import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/media_query.dart';
import 'package:expense_manager/core/widgets/app_alert_dialog.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/features/dashboard/widgets/card_widget.dart';
import 'package:expense_manager/features/dashboard/widgets/limit_card_widget.dart';
import 'package:expense_manager/features/transaction/bloc/transaction_bloc.dart';
import 'package:expense_manager/features/transaction/screens/add_transaction_bottom_sheet.dart';
import 'package:expense_manager/features/transaction/widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoaded) {
                return SizedBox(
                  height: MQ.height(context),
                  child: _dashboardView(state: state),
                );
              } else {
                return Center(child: Text("Error"));
              }
            },
          ),

          //------------- add transation button -----------
          Positioned(
            bottom: MQ.h(context, 15),
            right: MQ.w(context, 8),
            child: FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.bottomSheetBg,
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const AddTransactionBottomSheet(),
              ),
              backgroundColor: AppColors.green,
              shape: const CircleBorder(),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _dashboardView({required DashboardLoaded state}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ScreenPadding(
            child: Text(
              "👋 Welcome,${state.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ScreenPadding(
            child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    title: "Total Income",
                    isIncome: true,
                    price: "${state.totalIncome}",
                  ),
                ),
                AppSpacing.wBox15,
                Expanded(
                  child: CardWidget(
                    title: "Total Expense",
                    isIncome: false,
                    price: "${state.totalExpense}",
                  ),
                ),
              ],
            ),
          ),
          ScreenPadding(top: 0, child: LimitCardWidget()),
          Divider(),
          AppSpacing.hBox15,
          ScreenPadding(
            top: 0,
            bottom: 0,
            child: Text(
              "Recent Transactions",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          //--------------- transation list ----------
          ScreenPadding(
            child: state.recentTransactions.isEmpty
                ? Center(
                    child: Text(
                      "No Transactions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 100),
              itemCount: state.recentTransactions.length,
              itemBuilder: (context, index) {
                final transation = state.recentTransactions[index];
                final bool isCredit = transation.type == "credit"
                    ? true
                    : false;
                return TransactionTileWidget(
                  title: transation.note,
                  category: transation.categoryName,
                  date: transation.timestamp,
                  amount: transation.amount,
                  isCredit: isCredit,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (_) => AppAlertDialog(
                        title: "Delete Transaction",
                        message:
                            "Are you sure you want to delete this transaction?",
                        confirmText: "Delete",
                        onConfirm: () {
                          context.read<TransactionBloc>().add(
                            DeleteTransaction(transation.id),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
