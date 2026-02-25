import 'package:expense_manager/features/dashboard/screens/dashboard_tab.dart';
import 'package:expense_manager/features/dashboard/widgets/floating_navbar.dart';
import 'package:expense_manager/features/profile/screens/profile_screen.dart';
import 'package:expense_manager/features/transaction/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = [
    const Center(child: DashboardTab()),
    const Center(child: TransactionsScreen()),
    Center(child: ProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: pages[index]),

          FloatingNavBar(
            currentIndex: index,
            onTap: (i) => setState(() => index = i),
          ),
        ],
      ),
    );
  }
}
