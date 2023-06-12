import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Today's 툰s",
            style: TextStyle(color: Colors.green),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}