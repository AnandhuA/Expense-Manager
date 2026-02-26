import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/media_query.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/dashboard/widgets/card_widget.dart';
import 'package:expense_manager/features/dashboard/widgets/limit_card_widget.dart';
import 'package:expense_manager/features/transaction/screens/add_transaction_bottom_sheet.dart';
import 'package:expense_manager/features/transaction/screens/transaction_list.dart';
import 'package:flutter/material.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                ScreenPadding(
                  child: Text(
                    "👋 Welcome,Anandhu",
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
                          price: "90,000",
                        ),
                      ),
                      AppSpacing.wBox15,
                      Expanded(
                        child: CardWidget(
                          title: "Total Expense",
                          isIncome: false,
                          price: "90,000",
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
                  
                  child: TransactionList(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  )
                ),
              ],
            ),
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
}
