import 'package:flutter/material.dart';

class Task {
  final String title;
  final String location;
  final double price;
  final String category;
  final bool isAvailable;

  Task(this.title, this.location, this.price, this.category, this.isAvailable);
}

List<Task> allTasks = [
  // Gardening Tasks
  Task('Plant a tree in the garden', 'MG Road', 500, 'Gardening', true),
  Task('Mow the lawn', 'Vijay Nagar', 300, 'Gardening', true),
  Task('Water the garden', 'LIG', 150, 'Gardening', false),
  Task('Plant flowers in the backyard', 'Annpurna', 400, 'Gardening', true),
  Task('Garden clean-up', 'Dewas Naka', 250, 'Gardening', true),
  Task('Fertilize the plants', 'Vijay Nagar', 200, 'Gardening', true),
  Task('Trim the bushes', 'MG Road', 350, 'Gardening', false),
  Task('Set up an irrigation system', 'Mhow', 700, 'Gardening', true),

  // Other Categories
  Task('Fix kitchen sink', 'Mhow', 500, 'Plumbing', true),
  Task('Walk the dog', 'Mhow', 350, 'Pet Care', true),
];

class GardeningPage extends StatefulWidget {
  const GardeningPage({super.key});

  @override
  State<GardeningPage> createState() => _GardeningPageState();
}

class _GardeningPageState extends State<GardeningPage> {
  String selectedSort = 'None';
  String selectedLocation = 'All';
  bool onlyAvailable = false;

  List<String> getLocations() {
    return [
      'All',
      ...{for (var task in allTasks) task.location}
    ];
  }

  List<Task> getFilteredTasks() {
    List<Task> tasks =
        allTasks.where((task) => task.category == 'Gardening').toList();

    if (selectedLocation != 'All') {
      tasks = tasks.where((task) => task.location == selectedLocation).toList();
    }

    if (onlyAvailable) {
      tasks = tasks.where((task) => task.isAvailable).toList();
    }

    if (selectedSort == 'Price: Low to High') {
      tasks.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSort == 'Price: High to Low') {
      tasks.sort((a, b) => b.price.compareTo(a.price));
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = getFilteredTasks();
    List<String> locations = getLocations();

    return Scaffold(
      appBar: AppBar(
        title: Text('Gardening Tasks'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedSort = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'None', child: Text('No Sorting')),
              PopupMenuItem(
                  value: 'Price: Low to High',
                  child: Text('Price: Low to High')),
              PopupMenuItem(
                  value: 'Price: High to Low',
                  child: Text('Price: High to Low')),
            ],
          ),
        ],
      ),
      body: ListView(
        // Replace SingleChildScrollView with ListView
        children: [
          // Filters Section
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedLocation,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                        ),
                        items: locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedLocation = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Checkbox(
                          value: onlyAvailable,
                          onChanged: (value) {
                            setState(() {
                              onlyAvailable = value ?? false;
                            });
                          },
                        ),
                        const Text("Available Only")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

          // Task List Section
          tasks.isEmpty
              ? Center(child: Text('No tasks available.'))
              : ListView.builder(
                  shrinkWrap: true, // Shrinks the ListView
                  physics:
                      NeverScrollableScrollPhysics(), // Disable internal scroll
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(task.title,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(task.location),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹${task.price.toStringAsFixed(0)}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                            if (!task.isAvailable)
                              Text("Unavailable",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
