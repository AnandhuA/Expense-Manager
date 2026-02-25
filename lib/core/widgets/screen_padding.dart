import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final double top;
  final double bottom;
  final double right;
  final double left;

  const ScreenPadding({
    super.key,
    required this.child,
    this.bottom = 18,
    this.left = 18,
    this.right = 18,
    this.top = 18,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        right: right,
        left: left,
      ),
      child: child,
    );
  }
}