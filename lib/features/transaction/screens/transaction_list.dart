import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/widgets/app_alert_dialog.dart';
import 'package:expense_manager/features/transaction/bloc/transaction_bloc.dart';
import 'package:expense_manager/features/transaction/widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TransactionList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  const TransactionList({super.key, this.shrinkWrap = false, this.physics});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          Center(child: SpinKitThreeBounce(color: AppColors.white, size: 20));
        }
        if (state is TransactionError) {
          Center(child: Text(state.message));
        }
        if (state is TransactionLoaded) {
          return state.transactions.isEmpty
              ? Center(
                  child: Text(
                    "No Transactions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
            shrinkWrap: shrinkWrap,
            physics: physics,
            padding: EdgeInsets.only(bottom: 100),
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final transation = state.transactions[index];
              final bool isCredit = transation.type == "credit" ? true : false;
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
          );
        } else {
          return Center(child: Text("error"));
        }
      },
    );
  }
}
