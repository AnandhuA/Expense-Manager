import 'package:expense_manager/core/constants/app_spacing.dart';
import 'package:expense_manager/core/utils/validators.dart';
import 'package:expense_manager/features/auth/screeens/otp_screen.dart';
import 'package:expense_manager/features/auth/screeens/widgets/title_widget.dart';
import 'package:flutter/material.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(18),
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
                    prefixIcon: IconButton(onPressed: null, icon: Text("+91")),
                  ),
                ),
              ),
              AppSpacing.hBox25,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final phone = _phoneController.text.trim();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(phoneNumber: phone),
                      ),
                    );
                  }
                },
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
