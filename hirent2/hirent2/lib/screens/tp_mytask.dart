import 'package:flutter/material.dart';
import 'package:hirent2/screens/create_task.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

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
            Navigator.pop(context); // Navigate back to previous screen
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateTaskScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Create Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              child: ListView(
                children: const [
                  TaskCard(
                    title: 'Cleaning Task',
                    description:
                        'This is a cleaning task that needs to be done. The task involves helping with cleaning services.',
                    location: 'San Francisco, CA',
                    category: 'Cleaning',
                    imageUrl: '',
                    price: '₹50',
                    daysAgo: 1,
                  ),
                  TaskCard(
                    title: 'Babysitting Task',
                    description:
                        'This is a babysitting task that needs to be done. The task involves helping with babysitting services.',
                    location: 'Los Angeles, CA',
                    category: 'Babysitting',
                    imageUrl: '',
                    price: '₹70',
                    daysAgo: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'My Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget filterTab(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        Icon(icon, color: isActive ? Colors.deepPurple : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              color: isActive ? Colors.deepPurple : Colors.grey,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        if (isActive)
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          )
      ],
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
    super.key,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.daysAgo,
  });

  @override
  Widget build(BuildContext context) {
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
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                        ),
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
                    color: category == 'Cleaning'
                        ? Colors.blue
                        : category == 'Babysitting'
                            ? Colors.pink
                            : Colors.deepPurple,
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
                    '$daysAgo day${daysAgo > 1 ? 's' : ''} ago',
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
                  description,
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
