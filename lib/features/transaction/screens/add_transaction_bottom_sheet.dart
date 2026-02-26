import 'dart:developer';

import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/categories/bloc/category_bloc.dart';
import 'package:expense_manager/features/transaction/bloc/transaction_bloc.dart';
import 'package:expense_manager/features/transaction/widgets/type_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  bool isExpense = true;
  String? selectedCategoryId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionLoaded) {
              Navigator.pop(context);
            }
            if (state is TransactionError) {
              log("error ${state.message}");
            }
          },
          child: ScreenPadding(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Transaction",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),

                AppSpacing.hBox15,

                /// EXPENSE / INCOME TOGGLE
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      TypeButtonWidget(
                        title: "Expense",
                        selected: isExpense,
                        onTap: () => setState(() => isExpense = true),
                      ),
                      TypeButtonWidget(
                        title: "Income",
                        selected: !isExpense,
                        onTap: () => setState(() => isExpense = false),
                      ),
                    ],
                  ),
                ),

                AppSpacing.hBox15,

                /// TITLE
                TextField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hint: Text("Title")),
                ),

                AppSpacing.hBox10,

                /// AMOUNT
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hint: Text("Amount ( ₹ )")),
                ),

                AppSpacing.hBox15,

                /// CATEGORY
                const Text(
                  "CATEGORY",
                  style: TextStyle(fontSize: 12, color: AppColors.textHint),
                ),

                AppSpacing.hBox10,

                _buildCategory(),

                AppSpacing.hBox15,

                /// INFO BOX
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, size: 18, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Everything you add here is saved only on your device.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                AppSpacing.hBox20,

                /// SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (selectedCategoryId != null &&
                          _titleController.text.isNotEmpty &&
                          _amountController.text.isNotEmpty) {
                        final double amount =
                            double.tryParse(_amountController.text.trim()) ?? 0;
                        final note = _titleController.text.trim();
                        final String type = isExpense ? "debit" : "credit";
                        context.read<TransactionBloc>().add(
                          AddTransaction(
                            amount: amount,
                            note: note,
                            type: type,
                            categoryId: selectedCategoryId!,
                          ),
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
                AppSpacing.hBox25,
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> _buildCategory() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const CircularProgressIndicator();
        }

        if (state is CategoryLoaded) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return const Text("No categories found");
          }

          return Wrap(
            spacing: 10,
            children: List.generate(categories.length, (index) {
              final cat = categories[index];

              return ChoiceChip(
                label: Text(cat.name),
                selected: selectedCategoryId == cat.id,
                side: BorderSide(color: AppColors.grey),

                onSelected: (_) {
                  setState(() => selectedCategoryId = cat.id);
                },

                selectedColor: AppColors.primary,
                backgroundColor: const Color(0xFF2A2A2A),

                labelStyle: TextStyle(
                  color: selectedCategoryId == cat.id
                      ? AppColors.white
                      : AppColors.white.withValues(alpha: 0.7),
                ),
              );
            }),
          );
        }

        if (state is CategoryError) {
          return Text(state.message, style: TextStyle(color: AppColors.error));
        }

        return const SizedBox();
      },
    );
  }
}
