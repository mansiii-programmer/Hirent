import 'package:flutter/material.dart';
import 'package:hirent2/screens/home_screen.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sign_in_screen.dart';
import 'package:hirent2/screens/signup_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';
import 'package:hirent2/screens/your_tasks.dart' as tasks;

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/hirentlogo.jpg'),
      ),
    );
  }
}
