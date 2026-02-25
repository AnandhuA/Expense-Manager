import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/profile/widgets/profile_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final categories = ["Food", "Bills", "Transport", "Shopping"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ScreenPadding(
          bottom: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              const Text(
                "Profile & Settings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              AppSpacing.hBox20,

              /// ---------------- NICKNAME ----------------
              Text("NICKNAME"),
              AppSpacing.hBox10,
              ProfileCardWidget(
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Naazley",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 18),
                    ),
                  ],
                ),
              ),

              AppSpacing.hBox20,

              /// ---------------- ALERT LIMIT ----------------
              Text("ALERT LIMIT (₹)"),
              AppSpacing.hBox10,

              ProfileCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount ( ₹ )",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        AppSpacing.wBox10,
                        SizedBox(
                          height: 50,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: () {},
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: ,
                            // ),
                            child: const Text("Set"),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.hBox10,
                    const Text(
                      "Current Limit: ₹1,000",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              AppSpacing.hBox20,

              /// ---------------- CATEGORIES ----------------
              Text("CATEGORIES"),
              AppSpacing.hBox10,

              ProfileCardWidget(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
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
                            onPressed: () {},
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: ,
                            // ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(categories[index]),
                          trailing: IconButton(
                            icon: SvgPicture.asset(AppAssets.deleteIcon2),
                            onPressed: () {},
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  ],
                ),
              ),
              AppSpacing.hBox20,

              /// ---------------- CLOUD SYNC ----------------
              Text("CLOUD SYNC"),
              AppSpacing.hBox10,

              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.blue],
                  ),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync To Cloud",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Sync and update data to the backend",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.cloud_upload),
                  ],
                ),
              ),
              AppSpacing.hBox20,

              // /// ---------------- LOG OUT ----------------
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Log Out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// SECTION TITLE
  // Widget _sectionTitle(String title) {
  //   return Text(
  //     title,
  //     style: const TextStyle(
  //       fontSize: 12,
  //       color: Colors.grey,
  //       letterSpacing: 1,
  //     ),
  //   );
  // }

  /// CATEGORY ITEM
}
