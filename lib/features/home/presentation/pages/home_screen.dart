import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('Home Screen')),
    );
  }
}
