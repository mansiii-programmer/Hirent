import 'package:flutter/material.dart';
import 'package:hirent2/screens/ts_homescreen.dart';
import 'package:hirent2/screens/communication_screen.dart';
import 'package:hirent2/screens/chatting_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';
import 'package:hirent2/screens/your_tasks.dart';

class SeekerMainScreen extends StatefulWidget {
  const SeekerMainScreen({super.key});

  @override
  State<SeekerMainScreen> createState() => _SeekerMainScreenState();
}

class _SeekerMainScreenState extends State<SeekerMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TsHomePage(),
    ChatNegotiationPage(),
    ChatScreen(),
    YourTasksPage(),
    ProfileSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFD8B4F8),
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFFFAFAFA),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Comm'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
