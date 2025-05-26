import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hirent2/screens/sharedpref.dart';
import 'package:http/http.dart' as http;

class TsHomePage extends StatefulWidget {
  final String seekerId; // pass this on navigation

  const TsHomePage({super.key, required this.seekerId});

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

  Future<void> acceptTask(String taskId) async {
    final url = Uri.parse('http://127.0.0.1:8000/tasks/accept/$taskId');
    final String? userId = await SharedPrefService.getUserId();

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'assigned_to': userId}),
      );
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['message'] ==
              'Task accepted successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task accepted successfully')),
        );
        // Refresh task list
        setState(() {
          futureTasks = fetchTasksFromDatabase();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task already assigned or not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
                color: Color(0xFFF3ECFF),
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
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: futureTasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final filteredTasks = snapshot.data!
                    .where((task) =>
                        task.title.toLowerCase().contains(searchQuery) ||
                        task.description.toLowerCase().contains(searchQuery) ||
                        task.location.toLowerCase().contains(searchQuery))
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredTasks.length,
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
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => acceptTask(task.taskId),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Accept"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'My Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class Task {
  final String taskId;
  final String category;
  final String title;
  final String description;
  final String location;
  final String timeAgo;
  final String price;
  final String imagePath;

  Task({
    required this.taskId,
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.timeAgo,
    required this.price,
    required this.imagePath,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['_id'].toString(),
      category: map['category'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      timeAgo: map['timeAgo'] ?? '',
      price: map['price'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}
