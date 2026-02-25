import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/media_query.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/core/widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              ScreenPadding(
                child: Text(
                  "👋 Welcome,Anandhu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              AppSpacing.hBox20,
              ScreenPadding(
                child: Text(
                  "Recent Transactions",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ScreenPadding(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: 10,
                    itemBuilder: (context, index) => TransactionTileWidget(
                      title: "Title",
                      category: "category",
                      date: DateTime.now(),
                      amount: 200,
                      isCredit: index % 2 == 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MQ.h(context, 15),
            right: MQ.w(context, 8),
            child: FloatingActionButton(
              onPressed: () {},
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
