import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  List<TaskCardData> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    // Change this URL to your backend URL
    final url = Uri.parse('http://192.168.29.211:8000/tasks/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<TaskCardData> fetchedTasks = data.map((taskJson) {
          return TaskCardData(
            title: taskJson['title'] ?? '',
            description: taskJson['description'] ?? '',
            location: taskJson['location'] ?? '',
            category: taskJson['category'] ?? '',
            imageUrl: '',  // No image from backend yet
            price: '₹${taskJson['amount'] ?? 0}',
            daysAgo: 1,
          );
        }).toList();

        setState(() {
          tasks = fetchedTasks;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posted Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Posted Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      filterTab(Icons.folder, 'All', true),
                      filterTab(Icons.check_circle, 'Open', false),
                      filterTab(Icons.done, 'Completed', false),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskCard(
                          title: task.title,
                          description: task.description,
                          location: task.location,
                          category: task.category,
                          imageUrl: task.imageUrl,
                          price: task.price,
                          daysAgo: task.daysAgo,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (value) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget filterTab(IconData icon, String label, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.orangeAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String category;
  final String imageUrl;
  final String price;
  final int daysAgo;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.daysAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // You can add Image.network here if you have imageUrl
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Text("Location: $location"),
            Text("Category: $category"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$daysAgo days ago"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCardData {
  final String title;
  final String description;
  final String location;
  final String category;
  final String imageUrl;
  final String price;
  final int daysAgo;

  TaskCardData({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.daysAgo,
  });
}
