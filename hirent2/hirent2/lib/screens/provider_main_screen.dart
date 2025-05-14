import 'package:flutter/material.dart';
import 'package:hirent2/screens/chatting_screen.dart';
import 'package:hirent2/screens/tp_homepage.dart';
import 'package:hirent2/screens/post_task_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';

class ProviderMainScreen extends StatefulWidget {
  const ProviderMainScreen({super.key});

  @override
  State<ProviderMainScreen> createState() => _SeekerMainScreenState();
}

class _SeekerMainScreenState extends State<ProviderMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatScreen(),
    PostTaskPage(),
    ProfileSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
    );
  }
}
