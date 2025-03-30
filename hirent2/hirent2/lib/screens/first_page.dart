import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
              Color(0xff7B6190), // exact purple color
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Center( // centers the entire content
          child: Column(
            mainAxisSize: MainAxisSize.min, // keeps content compact
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // hirent text
              const Text(
                'HIRENT',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50), // space before button

              // continue button
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8345B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Tap to Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white, ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
