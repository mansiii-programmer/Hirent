import 'package:flutter/material.dart';
import 'package:hirent2/screens/sharedpref.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'edit_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// User model
class UserProfile {
  final String name;
  final String email;
  final String location;

  UserProfile(
      {required this.name, required this.email, required this.location});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['username'] ?? 'Unknown',
      email: json['email'] ?? 'unknown@example.com',
      location: json['location'] ?? 'Not set',
    );
  }
}

Future<UserProfile> fetchUserProfile() async {
  final String? userId = await SharedPrefService.getUserId(); // async get
  if (userId == null) throw Exception('User ID not found');

  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/users/users/$userId'),
  );

  if (response.statusCode == 200) {
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user profile');
  }
}

class TSProfileSettingsPage extends StatelessWidget {
  const TSProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F4),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: Colors.black87,
      ),
      body: FutureBuilder<UserProfile>(
        future: fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No user data found."));
          }

          final user = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 14, 113, 128),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person_outline,
                                color: Colors.teal, size: 30),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(user.email,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.white, size: 14),
                                  const SizedBox(width: 4),
                                  Text(user.location,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(height: 24, color: Colors.transparent),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _ProfileStat(count: "0", label: "Tasks"),
                          VerticalDivider(color: Colors.white70, thickness: 1),
                          _ProfileStat(count: "★ 0.0", label: "Rating"),
                          VerticalDivider(color: Colors.white70, thickness: 1),
                          _ProfileStat(count: "₹0", label: "Earned"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const _ProfileItem(
                    icon: LucideIcons.checkSquare,
                    title: "Your Tasks",
                    routeName: '/ts_yourtasks'),
                const _ProfileItem(
                    icon: LucideIcons.messageCircle,
                    title: "Messages",
                    routeName: '/ts_messages'),
                const _ProfileItem(
                    icon: LucideIcons.creditCard,
                    title: "Payment History",
                    routeName: '/paymentHistory'),
                const _ProfileItem(
                    icon: LucideIcons.wallet,
                    title: "Wallet",
                    routeName: '/wallet'),
                const _ProfileItem(
                    icon: LucideIcons.shieldCheck,
                    title: "Security",
                    routeName: '/security'),
                const _ProfileItem(
                    icon: LucideIcons.settings,
                    title: "Settings",
                    routeName: '/settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String count;
  final String label;

  const _ProfileStat({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF7F9FA),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF0E807A)),
        title: Text(title),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          if (routeName.isNotEmpty) {
            Navigator.pushNamed(context, routeName);
          }
        },
      ),
    );
  }
}
