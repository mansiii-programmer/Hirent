import 'package:flutter/material.dart';
import 'package:hirent2/screens/sharedpref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourTasksPage extends StatefulWidget {
  const YourTasksPage({super.key});

  @override
  State<YourTasksPage> createState() => _YourTasksPageState();
}

class _YourTasksPageState extends State<YourTasksPage> {
  List acceptedTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchAcceptedTasks();
  }

  Future<void> _fetchAcceptedTasks() async {
    final String? userId = await SharedPrefService.getUserId();
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/tasks/assigned/$userId'));

    if (response.statusCode == 200) {
      final taskList = jsonDecode(response.body);
      setState(() {
        acceptedTasks = taskList["assigned_tasks"];
      });
    } else {
      // Handle error
      print('Failed to load tasks: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F6),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Tasks',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1EEE5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF2684FC),
                              width: 3.0,
                            ),
                          ),
                        ),
                        labelColor: Color(0xFF2684FC),
                        unselectedLabelColor: Colors.brown.shade400,
                        tabs: const [
                          Tab(icon: Icon(Icons.inventory), text: 'All'),
                          Tab(icon: Icon(Icons.schedule), text: 'Open'),
                          Tab(
                              icon: Icon(Icons.check_circle),
                              text: 'Completed'),
                        ],
                      )),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  taskListView(),
                  taskListView(), // Can be filtered later
                  taskListView(), // Can be filtered later
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget taskListView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: acceptedTasks.map((task) {
          return buildTaskCard(
            category: task['category'] ?? "",
            title: task['title'] ?? "",
            desc: task['description'] ?? "",
            location: task['location'] ?? "",
            price: task['price'] ?? "",
            imageUrl: "",
            color: Colors.grey,
          );
        }).toList(),
      ),
    );
  }

  Widget buildTaskCard({
    required String category,
    required String title,
    required String desc,
    required String location,
    required String price,
    required String imageUrl,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "30m",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 13)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        price,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
