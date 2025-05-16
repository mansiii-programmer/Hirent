import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleGradient = LinearGradient(
      colors: [Color(0xFFE96443), Color(0xFF904E95)], // orange to pink-purple
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF4E5), Color(0xFFFDECEF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// HIRENT logo with gradient
                ShaderMask(
                  shaderCallback: (bounds) =>
                      titleGradient.createShader(bounds),
                  child: const Text(
                    'HIRENT',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Subtitle
                const Text(
                  "India's fastest growing platform for local\nservices and short-term tasks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),

                /// Prompt
                const Text(
                  "I am looking to:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                /// Find Tasks (Seeker)
                TapScaleContainer(
                  onTap: () {
                    Navigator.pushNamed(context, '/seekerLogin');
                  },
                  child: _OptionCard(
                    title: 'Find Tasks',
                    description:
                        'Browse available gigs and earn money in your free time',
                    footerText:
                        'Perfect for students, part-timers, and freelancers',
                    backgroundColor: Color(0xFFFCFCFA),
                  ),
                ),

                const SizedBox(height: 20),

                /// Post Tasks (Provider)
                TapScaleContainer(
                  onTap: () {
                    Navigator.pushNamed(context, '/providerLogin');
                  },
                  child: _OptionCard(
                    title: 'Post Tasks',
                    description:
                        'Find skilled people to help with your tasks and projects',
                    footerText:
                        'Hire local talent for home, office or business needs',
                    backgroundColor: Color(0xFFFBFBF8),
                  ),
                ),

                const SizedBox(height: 30),

                /// Login Text
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signin'),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Card Widget
class _OptionCard extends StatefulWidget {
  final String title;
  final String description;
  final String footerText;
  final Color backgroundColor;

  const _OptionCard({
    required this.title,
    required this.description,
    required this.footerText,
    required this.backgroundColor,
  });

  @override
  State<_OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedScale(
            scale: _isHovered ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  if (_isHovered)
                    const BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 6),
                  Text(widget.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      )),
                  const SizedBox(height: 6),
                  Text(widget.footerText,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 248, 148, 61),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tap scale animation
class TapScaleContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const TapScaleContainer({required this.child, required this.onTap});

  @override
  State<TapScaleContainer> createState() => _TapScaleContainerState();
}

class _TapScaleContainerState extends State<TapScaleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scale = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.reverse();
  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => _controller.forward(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: widget.child,
      ),
    );
  }
}
