import 'dart:convert';
import 'package:flutter/material.dart';

class Task {
  final String category;
  final String title;
  final String description;
  final String location;
  final String timeAgo;
  final String price;
  final String imagePath;

  Task({
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.timeAgo,
    required this.price,
    required this.imagePath,
  });
}

class TsHomePage extends StatefulWidget {
  const TsHomePage({super.key});

  @override
  State<TsHomePage> createState() => _TsHomePageState();
}

class _TsHomePageState extends State<TsHomePage> {
  late Future<List<Task>> futureTasks;
  String searchQuery = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureTasks = fetchTasksFromDatabase();
  }

  Future<List<Task>> fetchTasksFromDatabase() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/tasks'));

    if (response.statusCode == 200) {
      final List<dynamic> taskList = jsonDecode(response.body);
      return taskList.map((taskData) => Task.fromMap(taskData)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/ts_yourtasks');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/ts_messages');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/ts_profile');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> acceptTask(String taskId, String assignedTo) async {
    final url = Uri.parse('http://127.0.0.1:8000/accept/$taskId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'assigned_to': assignedTo}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['message'] == "Task accepted successfully") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Task accepted")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error'] ?? "Error accepting task")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error")),
      );
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Task Seeker',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Search for tasks...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              task.imagePath,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const SizedBox(
                                height: 200,
                                child: Center(
                                    child: Icon(Icons.image_not_supported)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.category,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(task.description),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16),
                                        const SizedBox(width: 4),
                                        Text(task.location),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16),
                                        const SizedBox(width: 4),
                                        Text(task.timeAgo),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    task.price,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),

              const Text(
                "Recommended Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ...filteredTasks.map((task) => taskCard(task)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
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
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget taskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  task.imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      height: 160,
                      width: double.infinity,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[600],
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        task.timeAgo,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  task.description,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      task.location,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        task.price,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Accepted: ${task.title}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Accept'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
