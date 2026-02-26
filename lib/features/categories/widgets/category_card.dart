import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/core/widgets/app_snackbar.dart';
import 'package:expense_manager/features/categories/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "New category Name",
                    border: InputBorder.none,
                  ),
                ),
              ),

              AppSpacing.wBox10,

              SizedBox(
                height: 50,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    final name = controller.text.trim();

                    if (name.isNotEmpty) {
                      context.read<CategoryBloc>().add(AddCategory(name));

                      controller.clear();
                      AppSnackBar.success(
                        context,
                        "Category added successfully",
                      );
                    } else {
                      AppSnackBar.error(context, "Empty");
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),

          const Divider(),

          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CategoryError) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    state.message,
                    style: TextStyle(color: AppColors.error),
                  ),
                );
              }

              if (state is CategoryLoaded) {
                final categories = state.categories;

                if (categories.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No categories yet"),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, index) {
                    final cat = categories[index];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(cat.name),
                      trailing: IconButton(
                        icon: SvgPicture.asset(AppAssets.deleteIcon2),
                        onPressed: () {
                          context.read<CategoryBloc>().add(
                            DeleteCategory(cat.id),
                          );
                          AppSnackBar.success(context, "Delete successfully");
                        },
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
