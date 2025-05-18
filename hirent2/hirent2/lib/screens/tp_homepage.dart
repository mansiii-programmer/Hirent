import 'package:flutter/material.dart';

class TpHomeScreen extends StatefulWidget {
  const TpHomeScreen({super.key});

  @override
  State<TpHomeScreen> createState() => _TpHomeScreenState();
}

class _TpHomeScreenState extends State<TpHomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == 1) {
      // Navigate to create task page or your tasks page
      Navigator.pushNamed(context, '/tp_yourtasks').then((_) {
        // When coming back, reset currentIndex to 0 (Home)
        setState(() {
          _currentIndex = 0;
        });
      });
    } else if (index == 2) {
      Navigator.pushNamed(context, '/tp_messages').then((_) {
        setState(() {
          _currentIndex = 0;
        });
      });
    } else if (index == 3) {
      Navigator.pushNamed(context, '/tp_profile').then((_) {
        setState(() {
          _currentIndex = 0;
        });
      });
    } else {
      // For index 0 (home), update selected index normally
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF8E2DE2),
                  Color.fromARGB(255, 196, 167, 211),
                  Color.fromARGB(255, 137, 85, 164)
                ],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: const Text(
                'HIRENT',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Task Provider',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[700]),
            onPressed: () {
              // Add settings action here
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for task providers...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Cleaning'),
                _buildFilterChip('Babysitting'),
                _buildFilterChip('Gardening'),
                _buildFilterChip('Cooking'),
                _buildFilterChip('Pet Care'),
                _buildFilterChip('Tutoring'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: const [
                TaskSeekerCard(
                  name: 'Arjun Kumar',
                  location: 'Mumbai, Maharashtra',
                  skills: ['Cleaning', 'Gardening', 'Pet Care'],
                  tasksCompleted: 15,
                  rating: 4.8,
                ),
                TaskSeekerCard(
                  name: 'Needhi Sharma',
                  location: 'Delhi, NCR',
                  skills: ['Tutoring', 'Shopping', 'Delivery'],
                  tasksCompleted: 8,
                  rating: 4.5,
                ),
                TaskSeekerCard(
                  name: 'Rahul Verma',
                  location: 'Bangalore, Karnataka',
                  skills: ['Babysitting', 'Cooking', 'Cleaning'],
                  tasksCompleted: 23,
                  rating: 4.9,
                ),
                TaskSeekerCard(
                  name: 'Neha Patel',
                  location: 'Pune, Maharashtra',
                  skills: ['Gardening', 'Assembly', 'Moving'],
                  tasksCompleted: 11,
                  rating: 4.7,
                ),
                TaskSeekerCard(
                  name: 'Vikram Singh',
                  location: 'Hyderabad, Telangana',
                  skills: ['Pet Care', 'Delivery', 'Laundry'],
                  tasksCompleted: 9,
                  rating: 4.3,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'My Tasks',
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

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[200],
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class TaskSeekerCard extends StatelessWidget {
  final String name;
  final String location;
  final List<String> skills;
  final int tasksCompleted;
  final double rating;

  const TaskSeekerCard({
    super.key,
    required this.name,
    required this.location,
    required this.skills,
    required this.tasksCompleted,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name.split(' ')[0][0]),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location),
            Wrap(
              spacing: 6,
              children: skills
                  .map((skill) => Chip(
                        label: Text(skill),
                        labelStyle: const TextStyle(color: Colors.white),
                        backgroundColor: _getSkillColor(skill),
                      ))
                  .toList(),
            ),
            Text('$tasksCompleted tasks completed'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            Text(rating.toString()),
          ],
        ),
      ),
    );
  }

  Color _getSkillColor(String skill) {
    switch (skill) {
      case 'Cleaning':
        return Colors.blue;
      case 'Gardening':
        return Colors.green;
      case 'Pet Care':
        return Colors.purple;
      case 'Tutoring':
        return Colors.indigo;
      case 'Shopping':
        return Colors.teal;
      case 'Delivery':
        return Colors.orange;
      case 'Babysitting':
        return Colors.pink;
      case 'Cooking':
        return Colors.deepOrange;
      case 'Assembly':
        return Colors.deepPurpleAccent;
      case 'Moving':
        return Colors.lightBlue;
      case 'Laundry':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
}