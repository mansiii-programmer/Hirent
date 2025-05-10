import 'package:flutter/material.dart';
import 'package:hirent2/screens/home_screen.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sign_in_screen.dart';

void main() {
  runApp(const HirentApp());
}

class HirentApp extends StatelessWidget {
  const HirentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
      routes: {
        '/homescreen': (context) => const HomeScreen(
              isCurrentlySeeker: true,
            ),
        '/signin': (context) => const SignInPage(selectedRole: 'Seeker'),
        '/otp': (context) => const OTPVerificationPage(),
      },
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9768CF), // Purple text
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Enter your email to sign up for this app",
                style: TextStyle(fontSize: 14, color: Color(0xFFB78BDB)),
              ),
            ),
            const SizedBox(height: 20),

            // Email label
            const Text(
              'Email',
              style: TextStyle(fontSize: 14, color: Color(0xFF000000)),
            ),
            const SizedBox(height: 5),

            // Email input field
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                validator: _validateEmail,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300], // Light grey background
                  hintText: "email@domain.com",
                  hintStyle: const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB78BDB), // Purple button
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _continue,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.black, fontSize: 16), // Black text
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Or text
            const Center(
              child: Text(
                "or",
                style: TextStyle(color: Color(0xFF828282), fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),

            // Sign in button
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: Color(0xFFB78BDB), fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Terms & Privacy
            const Center(
              child: Text(
                "By clicking continue, you agree to our Terms of Service\nand Privacy Policy",
                style: TextStyle(color: Color(0xFF9768CF), fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
