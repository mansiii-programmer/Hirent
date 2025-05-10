import 'package:flutter/material.dart';
import 'package:hirent2/screens/role_selection.dart';
import 'package:hirent2/screens/home_screen.dart'; // Assuming you have this file for home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isCurrentlySeeker =
      false; // You should replace this with your actual session or login status check

  @override
  void initState() {
    super.initState();
    // Auto navigate after 3 seconds based on login/session status
    Future.delayed(const Duration(seconds: 3), () {
      navigateBasedOnLoginStatus();
    });
  }

  void navigateBasedOnLoginStatus() async {
    // Check if the user is logged in and if they're a Seeker or Provider
    bool isLoggedIn =
        await checkLoginStatus(); // Replace with actual login status check

    if (isLoggedIn) {
      // If user is logged in, navigate to the correct home screen based on `isCurrentlySeeker`
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(isCurrentlySeeker: isCurrentlySeeker),
        ),
      );
    } else {
      // If user is not logged in, navigate to the RoleSelectionPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RoleSelectionPage(isCurrentlySeeker: isCurrentlySeeker),
        ),
      );
    }
  }

  Future<bool> checkLoginStatus() async {
    // Replace with your actual login status check (e.g., shared preferences, Firebase, etc.)
    // For now, we simulate that the user is not logged in.
    return false; // Simulate logged out user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensures full-screen coverage
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Color(0xff7B6190), // Purple color
                ],
                stops: [0.0, 0.7, 1.0], // Smooth transition
              ),
            ),
          ),
          // Centered logo image
          Center(
            child: Image.asset(
              'assets/images/hirentlogo.jpg',
              width: 200, // Adjust size as needed
              fit: BoxFit.contain, // Ensures proper scaling
            ),
          ),
        ],
      ),
    );
  }
}
