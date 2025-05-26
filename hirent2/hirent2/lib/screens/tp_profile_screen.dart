import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'edit_profile.dart';

class TPProfileSettingsPage extends StatelessWidget {
  const TPProfileSettingsPage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 14, 113, 128),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person_outline,
                            color: Colors.teal, size: 30),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mansiiii",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("mansi.awasthi222@gmail.com",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("Mumbai, Maharashtra",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
                      );
                    },
                  ),
                ),
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
            const SizedBox(height: 16),
            const _ProfileItem(
                icon: LucideIcons.checkSquare,
                title: "Create tasks",
                routeName: '/tp_yourtasks'),
            const _ProfileItem(
                icon: LucideIcons.messageCircle,
                title: "Messages",
                routeName: '/tp_messages'),
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
