import 'package:flutter/material.dart';

class TaskSeekerProfile extends StatelessWidget {
  const TaskSeekerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Task Seeker Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // profile card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/arjun.png'), // replace with real image
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Arjun Kumar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text("@arjun_kumar", style: TextStyle(color: Colors.grey)),
                          const Text("Professional Task Seeker"),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              SizedBox(width: 4),
                              Text("4.8"),
                              SizedBox(width: 16),
                              Icon(Icons.task_alt, color: Colors.teal, size: 18),
                              SizedBox(width: 4),
                              Text("15 tasks"),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // contact info card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Contact Information", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(children: [Icon(Icons.location_on), SizedBox(width: 8), Text("Mumbai, Maharashtra")]),
                    SizedBox(height: 6),
                    Row(children: [Icon(Icons.email), SizedBox(width: 8), Text("arjun.kumar@email.com")]),
                    SizedBox(height: 6),
                    Row(children: [Icon(Icons.phone), SizedBox(width: 8), Text("+91 9876543210")]),
                    SizedBox(height: 6),
                    Row(children: [Icon(Icons.badge), SizedBox(width: 8), Text("Professional Task Seeker")]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // about me
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Experienced professional with 5+ years in various service tasks. "
                  "I take pride in delivering quality work on time and building lasting relationships with clients. "
                  "Available for flexible scheduling and committed to excellence.",
                ),
              ),
            ),

            const SizedBox(height: 16),

            // skills & services
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Skills & Services", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: const [
                        Chip(label: Text("Cleaning"),labelStyle: TextStyle(color: Colors.white), backgroundColor: Color.fromARGB(255, 37, 36, 36)),
                        Chip(label: Text("Gardening"),labelStyle: TextStyle(color: Colors.white), backgroundColor: Color.fromARGB(255, 37, 36, 36)),
                        Chip(label: Text("Pet Care"),labelStyle: TextStyle(color: Colors.white), backgroundColor: Color.fromARGB(255, 37, 36, 36)),
                        Chip(label: Text("Delivery"),labelStyle: TextStyle(color: Colors.white), backgroundColor: Color.fromARGB(255, 37, 36, 36)),
                        Chip(label: Text("Assembly"),labelStyle: TextStyle(color: Colors.white), backgroundColor: Color.fromARGB(255, 37, 36, 36)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // interests
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Interests", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: const [
                        Chip(label: Text("Photography")),
                        Chip(label: Text("Cooking")),
                        Chip(label: Text("Fitness")),
                        Chip(label: Text("Travel")),
                        Chip(label: Text("Reading")),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // send message
                    },
                    child: const Text("Send Message"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // hire for task
                    },
                    child: const Text("Hire for Task"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
