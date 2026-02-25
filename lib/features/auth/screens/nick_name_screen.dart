import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/features/auth/screens/widgets/title_widget.dart';
import 'package:expense_manager/features/dashboard/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NickNameScreen extends StatefulWidget {
  const NickNameScreen({super.key});

  @override
  State<NickNameScreen> createState() => _NickNameScreenState();
}

class _NickNameScreenState extends State<NickNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool isValid = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      final text = _nameController.text.trim();

      final valid = text.length >= 2;

      if (valid != isValid) {
        setState(() => isValid = valid);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!isValid) return;

    final name = _nameController.text.trim();
    context.read<AuthBloc>().add(CreateAccount(name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          //------------listener -------------
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            }
          },

          //--------ui -----------
          child: ScreenPadding(
            child: Column(
              children: [
                AppSpacing.hBox25,

                const TitleWidget(
                  title: "👋 What should we call you?",
                  subtitle: "This name stays only on your device.",
                ),

                AppSpacing.hBox20,

                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Eg: Johnnie",

                    suffixIcon: isValid
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(AppAssets.checkIcon),
                          )
                        : null,
                  ),
                ),

                AppSpacing.hBox20,

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final bool isLoading = state is AuthLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : isValid
                            ? _continue
                            : null,
                        child: isLoading
                            ? SpinKitThreeBounce(
                                color: AppColors.white,
                                size: 20,
                              )
                            : Text("Continue"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
