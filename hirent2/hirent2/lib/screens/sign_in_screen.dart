import 'package:flutter/material.dart';
import 'package:hirent2/screens/seeker_main_screen.dart';
import 'package:hirent2/screens/provider_main_screen.dart';

class SignInPage extends StatefulWidget {
  final String selectedRole; // <-- receives role

  const SignInPage({super.key, required this.selectedRole});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
      return 'Enter a valid @gmail.com email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{6,}$')
        .hasMatch(value)) {
      return 'Password must be at least 6 characters & alphanumeric';
    }
    return null;
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.selectedRole == 'Seeker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SeekerMainScreen()),
        );
      } else if (widget.selectedRole == 'Provider') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProviderMainScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields correctly")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 100),
            children: [
              const Center(
                child: Text(
                  'HI, WELCOME BACK!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9768CF),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Email',
                  style: TextStyle(fontSize: 14, color: Color(0xFFB78BDB))),
              const SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              const Text('Password',
                  style: TextStyle(fontSize: 14, color: Color(0xFFB78BDB))),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB78BDB),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _validateForm,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.black),
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
