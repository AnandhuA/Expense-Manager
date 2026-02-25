import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/core/widgets/transaction_tile_widget.dart';
import 'package:expense_manager/features/transaction/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transation = state.transactions[index];
                        final bool isCredit = transation.type == "credit"
                            ? true
                            : false;
                        return TransactionTileWidget(
                          title: transation.note,
                          category: transation.categoryName,
                          date: DateTime.now(),
                          amount: transation.amount,
                          isCredit: isCredit,
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("data"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
