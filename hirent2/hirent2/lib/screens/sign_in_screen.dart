import 'package:flutter/material.dart';
import 'package:hirent2/screens/sharedpref.dart';
import 'package:hirent2/screens/ts_homescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tp_homepage.dart';
import 'ts_homescreen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();

  bool _obscurePassword = true;

  String? _validateEmail(String? val) {
    if (val == null || val.isEmpty) return 'Required*';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(val)) {
      return 'Enter a valid @gmail.com email';
    }
    return null;
  }

  String? _validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Required*';
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(val)) {
      return 'Password must be at least 6 characters & alphanumeric';
    }
    return null;
  }

  String? _validateRole(String? val) {
    if (val == null || val.isEmpty) return 'Required*';
    final role = val.toLowerCase().trim();
    if (role != 'seeker' && role != 'provider') {
      return 'Role must be seeker or provider';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final enteredRole = _roleController.text.trim().toLowerCase();

    try {
      // Replace your backend url here. For emulator, use 10.0.2.2 instead of localhost.
      final url = Uri.parse('http://127.0.0.1:8000/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'role': enteredRole}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final user = data['user'];
        final backendRole = user['role'].toString().toLowerCase();

        print('Backend role: $backendRole');
        print('Entered role: $enteredRole');

        if (enteredRole != backendRole) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Role does not match our records")),
          );
          return;
        }
        final userId = user['_id']; // <-- add this line
        print(user);

        await SharedPrefService.saveUserId(userId.toString());
        print('User ID saved locally: $userId');

        // Navigate based on role
        if (backendRole == 'seeker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TsHomePage()),
          );
        } else if (backendRole == 'provider') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TpHomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unknown role received")),
          );
        }
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['detail'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Try again.")),
      );
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDF9),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HIRENT',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF018078),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text('Welcome back',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('Log in to your account',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: _validateEmail,
                    decoration: _inputDecoration('you@gmail.com'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: _validatePassword,
                    decoration:
                        _inputDecoration('Enter your password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _roleController,
                    validator: _validateRole,
                    decoration: _inputDecoration('Role (seeker or provider)'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF018078),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
