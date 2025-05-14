import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hirent2/screens/role_selection.dart';
import 'package:hirent2/screens/home_screen.dart'; // Adjust your path

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late AnimationController _circleController;

  @override
  void initState() {
    super.initState();

    // Text Animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutBack),
    );

    _textController.forward();

    // Circle animation controller
    _circleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();

    Future.delayed(const Duration(seconds: 4), () => _navigateNext());
  }

  Future<void> _navigateNext() async {
    bool isLoggedIn = await checkLoginStatus();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isCurrentlySeeker: false),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
      );
    }
  }

  Future<bool> checkLoginStatus() async {
    return false;
  }

  @override
  void dispose() {
    _textController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFF6F3EF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Floating Circles
          AnimatedBuilder(
            animation: _circleController,
            builder: (context, child) {
              return CustomPaint(
                painter: CirclePainter(_circleController.value),
                child: Container(),
              );
            },
          ),

          // Centered content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xff5897EE),
                            Color(0xffF17C44),
                            Color(0xffAE5EC1),
                          ],
                        ).createShader(Rect.fromLTWH(
                            -100, -100, bounds.width + 300, bounds.height + 300));
                      },
                      child: const Text(
                        "HIRENT",
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const Text(
                      "India's fastest growing platform for local\nservices and short-term tasks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double animationValue;
  CirclePainter(this.animationValue);

  final List<Offset> centers = [
    Offset(100, 300),
    Offset(400, 200),
    Offset(100, 500),
    Offset(150, 600),
    Offset(270, 400),
    Offset(80, 190),
  ];

  final List<double> radii = [30, 25, 32, 26, 33, 24];
  final List<Color> colors = [
    Color.fromARGB(255, 205, 147, 118),
    Color.fromARGB(255, 214, 163, 138),
    Color.fromARGB(255, 207, 170, 152),
    Color.fromARGB(255, 237, 211, 198),
    Color.fromARGB(255, 207, 186, 176),
    Color.fromARGB(255, 185, 132, 106),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < centers.length; i++) {
      final Offset center = Offset(
        centers[i].dx + sin(animationValue * 2 * pi + i) * 10,
        centers[i].dy + cos(animationValue * 2 * pi + i) * 10,
      );

      final Paint paint = Paint()..color = colors[i].withOpacity(0.3);
      canvas.drawCircle(center, radii[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
