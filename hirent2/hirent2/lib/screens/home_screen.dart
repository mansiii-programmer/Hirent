import 'package:flutter/material.dart';
import 'package:hirent2/screens/chatting_screen.dart';
import 'package:hirent2/screens/post_task_screen.dart';
import 'package:hirent2/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '51-B Alankar Palace',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // hirent title
          const Center(
            child: Text(
              'HIRENT!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 119, 57, 169)),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Where Tasks Meet The Perfect Match',
              style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 119, 57, 169), fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 20),

          // buttons for different pages
          _buildTaskCard(context, Icons.edit, 'Your Task', 'Post and monitor your task.', PostTaskPage()),
          _buildTaskCard(context, Icons.chat, 'Chat', 'Communicate and negotiate prices.', const ChatScreen()),
          _buildTaskCard(context, Icons.person, 'Profile', 'Manage and view your profile.', ManageProfilePage()),
        ],
      ),

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HIRENT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Your Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // button with navigation
  Widget _buildTaskCard(BuildContext context, IconData icon, String title, String description, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.black54),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 119, 57, 169))),
              const SizedBox(height: 3),
              Text(description, style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

