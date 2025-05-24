import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        leading: BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // account security
          sectionCard(
            icon: Icons.shield_outlined,
            title: 'Account Security',
            child: ListTile(
              title: Text('Change Password'),
              trailing: Icon(Icons.vpn_key_outlined),
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                // handle password change
              },
            ),
          ),
          const SizedBox(height: 20),

          // notifications & alerts
          sectionCard(
            icon: Icons.notifications_none,
            title: 'Notifications & Alerts',
            subtitle: 'Control how you receive security alerts about your account.',
            child: Column(
              children: [
                notificationTile('Email notifications'),
                const SizedBox(height: 8),
                notificationTile('SMS alerts'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // emergency support
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade100),
              borderRadius: BorderRadius.circular(12),
              color: Colors.red.shade50,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      'Emergency Support',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "If you're in an emergency situation related to a task, press the SOS button to alert our support team.",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // handle sos alert
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(child: Text('SOS Emergency Alert')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionCard({required IconData icon, required String title, String? subtitle, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.teal),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget notificationTile(String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        tileColor: Colors.blueGrey.shade50,
        title: Text(label),
        trailing: ElevatedButton(
          onPressed: () {
            // manage notification
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black87,
          ),
          child: Text('Manage'),
        ),
      ),
    );
  }
}
