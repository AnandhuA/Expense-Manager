import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/validators.dart';
import 'package:expense_manager/core/widgets/screen_padding.dart';
import 'package:expense_manager/features/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/features/auth/screens/nick_name_screen.dart';
import 'package:expense_manager/features/auth/screens/otp_screen.dart';
import 'package:expense_manager/features/auth/widgets/title_widget.dart';
import 'package:expense_manager/features/dashboard/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          //------------------ listener ----------------
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is OtpSent) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    phoneNumber: _phoneController.text.trim(),
                    otp: state.otp,
                  ),
                ),
              );
            }

            if (state is NeedNickname) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NickNameScreen()),
                (route) => false,
              );
            }
            if (state is Authenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            }
          },

          //------------------- ui ------------------
          builder: (context, state) {
            return ScreenPadding(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  TitleWidget(
                    title: "Get Started",
                    subtitle: "Log In Using Phone & OTP",
                  ),

                  AppSpacing.hBox40,
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: AppValidator.phone,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "Phone",
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: Text("+91"),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.hBox25,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final bool isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: !isLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  final phone = _phoneController.text.trim();
                                  context.read<AuthBloc>().add(SendOtp(phone));
                                }
                              }
                            : null,
                        child: isLoading
                            ? SpinKitThreeBounce(
                                color: AppColors.white,
                                size: 20,
                              )
                            : Text("Continue"),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
