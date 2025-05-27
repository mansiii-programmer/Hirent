import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:hirent2/screens/create_task.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  String selectedFilter = 'All';
  late TabController _tabController;
  List<dynamic> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          if (_tabController.index == 0) {
            selectedFilter = 'All';
          } else if (_tabController.index == 1)
            selectedFilter = 'Open';
          // ignore: curly_braces_in_flow_control_structures
          else if (_tabController.index == 2) selectedFilter = 'Completed';
        });
      }
    });
    _loadTasks(); // Load tasks when screen initializes
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    if (userId != null) {
      await _fetchTasks(userId);
    } else {
      print('User ID not found in SharedPreferences');
    }
  }

  Future<void> _fetchTasks(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:8000/tasks/posted/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _tasks = data['posted_tasks'];
        });
      } else {
        print('Failed to load tasks');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Tasks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateTaskScreen(
                            currentUserId: '',
                          )),
                );
                _loadTasks(); // Refresh tasks after returning from CreateTaskScreen
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Create Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            filterTab(Icons.folder, 'All'),
            filterTab(Icons.check_circle, 'Open'),
            filterTab(Icons.done, 'Completed'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Your Posted Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  taskListView(),
                  taskListView(),
                  taskListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterTab(IconData icon, String label) {
    final bool isActive = selectedFilter == label;
    return Tab(
      icon: Icon(icon, color: isActive ? Colors.deepPurple : Colors.grey),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.deepPurple : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget taskListView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: _tasks.map((task) {
          return buildTaskCard(
            category: task['category'] ?? 'Unknown',
            title: task['title'] ?? 'No Title',
            desc: task['description'] ?? '',
            location: task['location'] ?? 'Unknown',
            timeAgo: task['created_at'] ?? 'Just now',
            price: '₹${task['price'] ?? '0'}',
            imageUrl: task['image_url'] ?? '',
            color: Colors.blue,
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
    required String timeAgo,
    required String price,
    required String imageUrl,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    timeAgo,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(location,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  price,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
