import 'package:flutter/material.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sign_in_screen.dart';
import 'package:hirent2/screens/signup_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';
import 'package:hirent2/screens/your_tasks.dart' as tasks;
import 'package:hirent2/screens/splash_screen.dart';
import 'package:hirent2/screens/role_selection.dart';
import 'package:hirent2/screens/seeker_main_screen.dart';
import 'package:hirent2/screens/provider_main_screen.dart';

void main() {
  runApp(const HirentApp());
}

class HirentApp extends StatelessWidget {
  const HirentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: const Color(0xFFD8B4F8),
      ),
      home: const SplashScreen(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpScreen(),
        '/otp': (context) => const OTPVerificationPage(),

        // Main screens
        '/seekerMain': (context) => const SeekerMainScreen(),
        '/providerMain': (context) => const ProviderMainScreen(),

        // Common screens
        '/profile': (context) => const ProfileSettingsPage(),
        '/yourtasks': (context) => const tasks.YourTasksPage(),

        // ✅ Fixed: no parameters passed here
        '/role': (context) => const RoleSelectionPage(),

        // Login routes
        '/seekerLogin': (context) => SignUpScreen(),
        '/providerLogin': (context) => SignUpScreen(),
      },
    );
  }
}
