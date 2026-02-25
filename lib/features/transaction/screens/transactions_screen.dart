import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/core/widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenPadding(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "Transactions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            AppSpacing.hBox20,
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
