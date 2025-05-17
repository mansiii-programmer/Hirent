import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String role = args?['role'] ?? 'Unknown';

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'HIRENT',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffB58FE7),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Verify your account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "We've sent a verification code to your email. Please enter the code below to complete your registration.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Selected role: $role',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Verification Code',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      animationType: AnimationType.fade,
                      cursorColor: Colors.deepPurpleAccent,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: Colors.deepPurpleAccent,
                        inactiveColor: Colors.grey.shade300,
                        selectedColor: Colors.deepPurple,
                      ),
                      onChanged: (value) {
                        setState(() {
                          otp = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (otp.length != 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a 6-digit code.'),
                              ),
                            );
                            return;
                          }

                          final email = args?['email'];
                          final username = args?['username'];
                          final password = args?['password'];
                          final location = args?['location'];
                          final bio = args?['bio'];
                          final skills = args?['skills'];

                          // Step 1: Verify OTP
                          final verifyResponse = await http.post(
                            Uri.parse("http://127.0.0.1:8000/otp/verify"),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({"email": email, "otp": otp}),
                          );

                          if (verifyResponse.statusCode != 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Invalid or expired OTP. Please try again.")),
                            );
                            return;
                          }

                          // Step 2: Create account
                          final signupResponse = await http.post(
                            Uri.parse("http://127.0.0.1:8000/auth/signup"),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "username": username,
                              "email": email,
                              "password": password,
                              "role": role,
                              "location": location,
                              "phone": "0000000000", // Placeholder for now
                              "bio": bio,
                              "profile_picture": "",
                            }),
                          );

                          if (signupResponse.statusCode == 201) {
                            Navigator.pushReplacementNamed(
                              context,
                              role == 'Task Provider'
                                  ? '/providerMain'
                                  : '/seekerMain',
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Signup failed. Please try again.")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ).copyWith(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (states) => Colors.transparent,
                          ),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xffA66DD8), Color(0xff4C9EEB)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Verify Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Didn't receive the code?"),
                    const SizedBox(height: 4),
                    const Text(
                      "Resend code in 49s",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}