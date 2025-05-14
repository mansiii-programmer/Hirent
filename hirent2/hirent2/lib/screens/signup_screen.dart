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
        '/homescreen': (context) => const HomeScreen(isCurrentlySeeker: true),
        '/signin': (context) => const SignInPage(),
        '/otp': (context) => const OTPVerificationPage(),
      },
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isSeeker = true;

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/otp');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
        .hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "HIRENT",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 30),
              const Text("I am registering as a:"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _roleOption("Task Seeker",
                      "Find and complete tasks to earn money", true),
                  _roleOption("Task Provider",
                      "Post tasks and hire skilled individuals", false),
                ],
              ),
              const SizedBox(height: 20),
              _buildInputField(
                  controller: _nameController,
                  label: "Full Name",
                  hint: "Your full name"),
              const SizedBox(height: 15),
              _buildInputField(
                  controller: _emailController,
                  label: "Email address",
                  hint: "you@example.com",
                  validator: _validateEmail),
              const SizedBox(height: 15),
              _buildInputField(
                  controller: _passwordController,
                  label: "Password",
                  hint: "Enter your password",
                  obscureText: true,
                  validator: _validatePassword),
              const SizedBox(height: 15),
              _buildInputField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  hint: "Re-enter password",
                  obscureText: true,
                  validator: _validateConfirmPassword),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _continue,
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Already have an account?"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/signin'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleOption(String title, String description, bool seekerOption) {
  bool selected = isSeeker == seekerOption;
  return SizedBox(
    width: (MediaQuery.of(context).size.width - 70) / 2,
    child: GestureDetector(
      onTap: () {
        setState(() {
          isSeeker = seekerOption;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.teal.shade50 : Colors.white,
          border: Border.all(
            color: selected ? Colors.teal : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<bool>(
                  value: seekerOption,
                  groupValue: isSeeker,
                  onChanged: (val) => setState(() {
                    isSeeker = val!;
                  }),
                  activeColor: Colors.teal,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
