import 'package:flutter/material.dart';
import 'package:hirent2/screens/ts_service_foodDelivery.dart';
import 'package:hirent2/screens/ts_service_gardening.dart';

class TsHomePage extends StatelessWidget {
  const TsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Search bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for tasks",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Main Heading
              Text(
                "Hirent",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Find local professionals for your tasks",
                style: TextStyle(fontSize: 16, color: Colors.purple),
              ),
              SizedBox(height: 30),

              // Services
              Text(
                "Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    serviceIcon(
                      icon: Icons.shopping_bag,
                      label: "Food Delivery",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CategoryPage(category: "Food Delivery"),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    serviceIcon(
                      icon: Icons.grass,
                      label: "Gardening",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                GardeningPage(), // Corrected navigation to GardeningPage
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    serviceIcon(
                      icon: Icons.plumbing,
                      label: "Plumbing",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryPage(category: "Plumbing"),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    serviceIcon(
                      icon: Icons.assignment,
                      label: "Assignment",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CategoryPage(category: "Assignment"),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    serviceIcon(
                      icon: Icons.pets,
                      label: "Pet Care",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryPage(category: "Pet Care"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Featured Tasks
              Text(
                "Featured Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    featuredTaskCard(
                      "assets/blog.png",
                      "Write a blog post",
                      "\₹50",
                      "John D.",
                      "Lex Showcase LLC",
                    ),
                    featuredTaskCard(
                      "assets/plumbing.png",
                      "Fix kitchen sink",
                      "\₹30",
                      "Michael S.",
                      "30 min",
                    ),
                    featuredTaskCard(
                      "assets/dog.png",
                      "Dog walking",
                      "\₹30",
                      "Sarah W.",
                      "5:00 PM",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Service Icon Widget
  Widget serviceIcon({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: Container(
              width: 80,
              height: 80,
              child: Icon(icon, size: 40, color: Colors.purple),
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Featured Task Card Widget
  Widget featuredTaskCard(String imagePath, String title, String price,
      String user, String details) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.black54)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: Colors.black54),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(user,
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.business, size: 14, color: Colors.black54),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(details,
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                    ),
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
