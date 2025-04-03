import 'package:flutter/material.dart';
import 'package:hirent2/screens/home_screen.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sign_in_screen.dart';
import 'package:hirent2/screens/signup_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';
import 'package:hirent2/screens/your_tasks.dart' as tasks;
import 'package:hirent2/screens/splash_screen.dart';

void main() {
  runApp(const HirentApp());
}

class HirentApp extends StatelessWidget {
  const HirentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => SignUpScreen(),
        '/otp': (context) => const OTPVerificationPage(),
        '/homescreen': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileSettingsPage(),
        '/yourtasks': (context) => const tasks.YourTasksPage(),
      },
    );
  }
}
