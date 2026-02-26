import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/features/auth/screens/login_screen.dart';
import 'package:expense_manager/features/categories/widgets/category_card.dart';
import 'package:expense_manager/features/profile/widgets/profile_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(LoadProfile());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          }
        },
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
                editNickName(),

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

                CategoryCard(),
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
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogOutAccount());
                    },
                    child: const Text("Log Out"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<AuthBloc, AuthState> editNickName() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final controller = TextEditingController(text: state.nickname);

          return ProfileCardWidget(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final newName = controller.text.trim();
                    if (newName.isNotEmpty) {
                      context.read<AuthBloc>().add(UpdateNickname(newName));
                    }
                  },
                  icon: const Icon(Icons.check, size: 18),
                ),
              ],
            ),
          );
        }

        if (state is AuthLoading) {
          return SpinKitThreeBounce(color: AppColors.white, size: 20);
        }

        return const SizedBox();
      },
    );
  }
}
