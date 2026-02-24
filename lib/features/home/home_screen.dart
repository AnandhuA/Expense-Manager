import 'package:expense_manager/features/home/widgets/floating_navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = [
    const Center(child: Text("Dashboard")),
    const Center(child: Text("Sync")),
    const Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
