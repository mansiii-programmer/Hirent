import 'package:flutter/material.dart';

class YourTasksPage extends StatelessWidget {
  const YourTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F6),
        body: Column(
          children: [
            // Header and Tabs
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
                              color: Color(
                                  0xFF2684FC), // Match soft blue from the screenshot
                              width: 3.0,
                            ),
                          ),
                        ),
                        labelColor:
                            Color(0xFF2684FC), // Match blue icon + text color
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

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  taskListView(),
                  taskListView(), // Placeholder duplicate for Open
                  taskListView(), // Placeholder duplicate for Completed
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
        children: [
          buildTaskCard(
            category: "Cleaning",
            title: "Cleaning Task",
            desc:
                "This is a cleaning task that needs to be done. The task involves helping with cleaning services.",
            location: "San Francisco, CA",
            timeAgo: "1 day ago",
            price: "₹16",
            imageUrl:
                "https://images.unsplash.com/photo-1581579185169-fdcfb0b7d1a9",
            color: Colors.blue,
          ),
          buildTaskCard(
            category: "Babysitting",
            title: "Babysitting Task",
            desc:
                "This is a babysitting task that needs to be done. The task involves helping with babysitting services.",
            location: "New York, NY",
            timeAgo: "4 days ago",
            price: "₹50",
            imageUrl: "https://invalid.url/image.png", // to test fallback
            color: Colors.pink,
          ),
        ],
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with fallback and category badge
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
                    timeAgo,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          // Task info
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