import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
              Color(0xff7B6190), // exact purple color
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create an account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              "Enter your email to sign up for this app",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xff7B6190),
                hintText: "email@domain.com",
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7B6190),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // signup action here
              },
              child: Center(
                child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "or",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // go to sign-in page
                Navigator.pushNamed(context, '/signin');
              },
              child: Text("Sign in", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 20),
            Text(
              "By clicking continue, you agree to our Terms of Service\nand Privacy Policy",
              style: TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
