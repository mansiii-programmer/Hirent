import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({Key? key, required bool isCurrentlySeeker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color lightPurple = Color(0xFFB39DDB); // light purple shade

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Hirent!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Do you want to login as a Task Seeker or Task Provider?',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              /// Task Provider Button (now on top, purple, swapped icon)
              ElevatedButton.icon(
                icon: Icon(Icons.person), // swapped icon
                label: Text('Login as Task Provider'),
                onPressed: () {
                  Navigator.pushNamed(context, '/providerLogin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              /// Task Seeker Button (below, purple, swapped icon)
              ElevatedButton.icon(
                icon: Icon(Icons.handyman), // swapped icon
                label: Text('Login as Task Seeker'),
                onPressed: () {
                  Navigator.pushNamed(context, '/seekerLogin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
