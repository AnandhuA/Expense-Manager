import 'dart:developer';

import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/core/widgets/app_alert_dialog.dart';
import 'package:expense_manager/core/widgets/app_snackbar.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/features/auth/screens/login_screen.dart';
import 'package:expense_manager/features/categories/widgets/category_card.dart';
import 'package:expense_manager/features/profile/bloc/profile_bloc.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _limitController.dispose();

    super.dispose();
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
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            log("$state");
            if (state is ProfileLoading) {
              return Center(
                child: SpinKitThreeBounce(color: AppColors.white, size: 20),
              );
            }
            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: AppColors.error),
                ),
              );
            }
            if (state is ProfileLoaded) {
              _nameController.text = state.nickname;
              _limitController.text = state.alertLimit.toString();
              return SingleChildScrollView(
                child: ScreenPadding(
                  bottom: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE
                      const Text(
                        "Profile & Settings",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      AppSpacing.hBox20,

/// ---------------- NICKNAME ----------------
                      Text("NICKNAME"),
                      AppSpacing.hBox10,
                      ProfileCardWidget(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_nameController.text != state.nickname) {
                                  final newName = _nameController.text.trim();
                                  if (newName.isNotEmpty) {
                                    context.read<ProfileBloc>().add(
                                      UpdateNickname(newName),
                                    );
                                    AppSnackBar.success(
                                      context,
                                      "Name change successfully",
                                    );
                                  } else {
                                    AppSnackBar.error(context, "Add name");
                                  }
                                }
                              },
                              icon: const Icon(Icons.check, size: 18),
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
                                Expanded(
                                  child: TextField(
                                    controller: _limitController,
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
                                    onPressed: () {
                                      if (double.tryParse(
                                            _limitController.text,
                                          ) !=
                                          state.alertLimit) {
                                        final limit = _limitController.text
                                            .trim();

                                        if (limit.isNotEmpty) {
                                          context.read<ProfileBloc>().add(
                                            UpdateAlertLimit(
                                              double.tryParse(limit) ?? 1000,
                                            ),
                                          );
                                          AppSnackBar.success(
                                            context,
                                            "Limit added successfully",
                                          );
                                        } else {
                                          AppSnackBar.error(
                                            context,
                                            "Type Limit",
                                          );
                                        }
                                      }
                                    },
                                    // style: ElevatedButton.styleFrom(
                                    //   backgroundColor: ,
                                    // ),
                                    child: const Text("Set"),
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.hBox10,
                            Text(
                              "Current Limit: ₹${state.alertLimit}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                            showDialog(
                              context: context,
                              builder: (_) => AppAlertDialog(
                                title: "LogOut",
                                message: "Are you sure you want to LogOut?",
                                confirmText: "LogOut",
                                onConfirm: () {
                                  context.read<AuthBloc>().add(LogOutAccount());
                                },
                              ),
                            );
                          },
                          child: const Text("Log Out"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Error",
                  style: TextStyle(fontSize: 20, color: AppColors.error),
                ),
              );
            }
          
          },
        ),
      ),
    );
  }
}
