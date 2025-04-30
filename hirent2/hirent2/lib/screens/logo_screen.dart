import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // expands to fill the screen
        children: [
          // background image (full screen)
          Image.asset(
            'assets/images/hirentlogo.png',
            fit: BoxFit.cover, // fills the screen
          ),
          // overlaying text
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black
                  .withAlpha((255 * 0.6).toInt()), // slight transparency
              child: const Text(
                'Welcome to Hirent',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
