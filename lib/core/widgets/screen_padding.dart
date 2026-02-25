import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;

  const ScreenPadding({super.key, required this.child});

  static const EdgeInsets value = EdgeInsets.all(18);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: value,
      child: child,
    );
  }
}