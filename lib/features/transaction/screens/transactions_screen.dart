import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/transaction/screens/transaction_list.dart';
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
              child: TransactionList()
            ),
          ],
        ),
      ),
    );
  }
}
