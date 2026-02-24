import 'dart:developer';

import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/constants/app_colors.dart';
import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/formatters.dart';
import 'package:expense_manager/features/auth/screeens/nick_name_screen.dart';
import 'package:expense_manager/features/auth/screeens/widgets/otp_field.dart';
import 'package:expense_manager/features/auth/screeens/widgets/otp_timer.dart';
import 'package:expense_manager/features/auth/screeens/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen({super.key, required this.phoneNumber});

  final _formKey = GlobalKey<FormState>();

  String otpValue = "";

  void _verifyOtp({required BuildContext context}) {
    log("work");
    if (_formKey.currentState!.validate()) {
      if (otpValue.length == 6) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NickNameScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AppSpacing.hBox15,
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(AppAssets.back),
                ),
              ),
              AppSpacing.hBox20,

              TitleWidget(
                title: "Verify OTP",
                subtitle:
                    "Enter the 6-Digit code sent to ${Formatters.maskPhone(phoneNumber)}",
              ),
              AppSpacing.hBox5,
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Change Number",
                  style: TextStyle(color: AppColors.blue),
                ),
              ),
              AppSpacing.hBox40,
              Form(
                key: _formKey,
                child: OtpInputField(onCompleted: (otp) => otpValue = otp),
              ),
              AppSpacing.hBox40,

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _verifyOtp(context: context),
                  child: const Text("Verify"),
                ),
              ),
              AppSpacing.hBox30,
              Align(
                alignment: Alignment.centerLeft,
                child: OtpTimer(onResend: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
