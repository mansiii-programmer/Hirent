import 'package:flutter/material.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sign_in_screen.dart';
import 'package:hirent2/screens/signup_screen.dart';
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
      theme: ThemeData(
        primaryColor: const Color(0xff7B6190),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xff7B6190).withOpacity(0.2), // Fixed
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Color(0xff7B6190)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7B6190),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => SignUpScreen(),
        '/otp': (context) => const OTPVerificationPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

class SignUpPage {
  const SignUpPage();
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xff7B6190)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hirent',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Fixed text color contrast
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text('Continue', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hirent'),
        backgroundColor: const Color(0xff7B6190),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xff7B6190)],
          ),
        ),
        child: const Center(
          child: Text(
            'Welcome to the Main Page!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ), // Ensuring readability
          ),
        ),
      ),
    );
  }
}