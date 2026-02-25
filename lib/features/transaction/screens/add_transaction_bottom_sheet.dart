import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:flutter/material.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  bool isExpense = true;
  int selectedCategory = 1;

  final categories = ["Food", "Bills", "Transport", "Shopping"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  _typeButton(
                    title: "Expense",
                    selected: isExpense,
                    onTap: () => setState(() => isExpense = true),
                  ),
                  _typeButton(
                    title: "Income",
                    selected: !isExpense,
                    onTap: () => setState(() => isExpense = false),
                  ),
                ],
              ),
            ),

            AppSpacing.hBox15,

            /// TITLE
            _inputField(hint: "Title"),

            AppSpacing.hBox10,

            /// AMOUNT
            _inputField(
              hint: "Amount ( ₹ )",
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            /// CATEGORY
            const Text(
              "CATEGORY",
              style: TextStyle(fontSize: 12, color: AppColors.textHint),
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 10,
              children: List.generate(
                categories.length,
                (index) => ChoiceChip(
                  label: Text(categories[index]),
                  selected: selectedCategory == index,
                  side: BorderSide(color: AppColors.grey),
                  onSelected: (_) {
                    setState(() => selectedCategory = index);
                  },
                  selectedColor: AppColors.primary,
                  backgroundColor: const Color(0xFF2A2A2A),

                  labelStyle: TextStyle(
                    color: selectedCategory == index
                        ? AppColors.white
                        : AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

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
                onPressed: () {},
                child: const Text("Save"),
              ),
            ),
            AppSpacing.hBox25,
          ],
        ),
      ),
    );
  }

  /// TOGGLE BUTTON
  Widget _typeButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            color: selected ? AppColors.green : AppColors.shadow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD
  Widget _inputField({
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
