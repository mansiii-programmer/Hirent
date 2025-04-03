import 'package:flutter/material.dart';
import 'package:hirent2/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // auto navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // ensures full-screen coverage
        children: [
          // background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Color(0xff7B6190), // exact purple color
                ],
                stops: [0.0, 0.7, 1.0], // smooth transition
              ),
            ),
          ),
          // centered logo image
          Center(
            child: Image.asset(
              'assets/images/hirentlogo.jpg',
              width: 200, // adjust size as needed
              fit: BoxFit.contain, // ensures proper scaling
            ),
          ),
        ],
      ),
    );
  }
}
