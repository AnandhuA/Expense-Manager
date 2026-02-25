import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final Widget child;
  const ProfileCardWidget({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}