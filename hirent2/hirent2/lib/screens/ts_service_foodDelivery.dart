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
  // Food Delivery
  Task('Deliver lunch to office', 'Mhow', 150, 'Food Delivery', true),
  Task('Deliver groceries to home', 'Vijay Nagar', 200, 'Food Delivery', false),
  Task('Deliver fruits to apartment', 'LIG', 120, 'Food Delivery', true),
  Task('Midnight snack delivery', 'Vijay Nagar', 250, 'Food Delivery', true),
  Task('Deliver birthday cake', 'Annpurna', 180, 'Food Delivery', true),
  Task('Deliver parcel to hostel', 'Dewas Naka', 100, 'Food Delivery', false),
  Task('Tea and snacks for event', 'Vijay Nagar', 300, 'Food Delivery', true),

  // Other Categories
  Task('Fix kitchen sink', 'Mhow', 500, 'Plumbing', true),
  Task('Walk the dog', 'Mhow', 350, 'Pet Care', true),
];

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
        allTasks.where((task) => task.category == widget.category).toList();

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
        title: Text(widget.category),
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
      body: SingleChildScrollView(
        // Wrap everything inside a SingleChildScrollView
        child: Column(
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
                    shrinkWrap:
                        true, // Allows ListView to take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return Card(
                        color: Colors.grey.shade100,
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
      ),
    );
  }
}
