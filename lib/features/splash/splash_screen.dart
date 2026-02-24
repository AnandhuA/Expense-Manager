import 'package:expense_manager/core/constants/app_assets.dart';
import 'package:expense_manager/core/services/preference_service.dart';
import 'package:expense_manager/features/walkthrough/walkthrough_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIsLogin();
  }

  Future<void> _checkIsLogin() async {
    // splash delay
    await Future.delayed(const Duration(seconds: 2));

    // check token
    final token = PreferencesService().token;

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // go to home
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const HomeScreen()),
      // );
    } else {
      // go to login / walkthrough
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WalkthroughScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppAssets.logo)));
  }
}
