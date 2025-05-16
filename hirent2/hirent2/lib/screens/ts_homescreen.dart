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
  final List<String> categories = [
    "All",
    "Cleaning",
    "Babysitting",
    "Gardening",
    "Cooking",
    "Pet Care",
    "Tutoring",
    "Shopping",
    "Delivery"
  ];

  String selectedCategory = "All";

  final List<Task> allTasks = [
    Task(
      category: "Cleaning",
      title: "Cleaning Task",
      description:
          "This is a cleaning task that needs to be done. The task involves helping with cleaning services.",
      location: "San Francisco, CA",
      timeAgo: "1 day ago",
      price: "₹16",
      imagePath: "assets/cleaning.png",
    ),
    Task(
      category: "Babysitting",
      title: "Evening Babysitter",
      description: "Need someone to babysit for 3 hours in the evening.",
      location: "San Jose, CA",
      timeAgo: "4 days ago",
      price: "₹40",
      imagePath: "assets/babysitting.jpg",
    ),
    Task(
      category: "Cooking",
      title: "Home Chef",
      description: "Looking for someone to prepare home-cooked meals daily.",
      location: "Oakland, CA",
      timeAgo: "2 days ago",
      price: "₹30",
      imagePath: "assets/cooking.jpg",
    ),
  ];

  int _selectedIndex = 0;

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
    final List<Task> filteredTasks = selectedCategory == "All"
        ? allTasks
        : allTasks
            .where((task) => task.category
                .toLowerCase()
                .startsWith(selectedCategory.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Gradient HIRENT text
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF8E2DE2),
                            Color.fromARGB(255, 196, 167, 211),
                            Color.fromARGB(255, 137, 85, 164)
                          ],
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
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
                      // Task Seeker capsule
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
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
                  Icon(Icons.settings, color: Colors.grey[700]),
                ],
              ),
              const SizedBox(height: 20),

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
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color:
                                isSelected ? Colors.black87 : Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => selectedCategory = category);
                        },
                        selectedColor: Colors.white,
                        backgroundColor: const Color(0xFFF0EEE9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: isSelected ? 2 : 0,
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

              ...filteredTasks.map((task) => taskCard(task)).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
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
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
