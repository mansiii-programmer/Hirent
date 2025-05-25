import 'package:flutter/material.dart';
import 'package:hirent2/screens/sharedpref.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = false;
  bool darkMode = false;
  bool twoFactorAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          sectionTitle('Account'),
          settingsTileSwitch(
            icon: Icons.notifications_none,
            label: 'Notifications',
            value: notifications,
            onChanged: (val) => setState(() => notifications = val),
          ),
          settingsTileSwitch(
            icon: Icons.nightlight_round,
            label: 'Dark Mode',
            value: darkMode,
            onChanged: (val) => setState(() => darkMode = val),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing:
                Text('English', style: TextStyle(color: Colors.grey[600])),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          sectionTitle('Security'),
          ListTile(
            leading: const Icon(Icons.vpn_key),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          settingsTileSwitch(
            icon: Icons.lock_outline,
            label: 'Two-Factor Authentication',
            value: twoFactorAuth,
            onChanged: (val) => setState(() => twoFactorAuth = val),
          ),
          const SizedBox(height: 20),
          sectionTitle('App'),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text('App Version'),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.grey[600])),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About HIRENT'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 30),

          // 🚀 LOGOUT BUTTON
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              await SharedPrefService.remove('auth_token');
              // Replace current page with the login page
              Navigator.pushNamedAndRemoveUntil(
                  context, '/signin', (route) => false);
            },
          ),

          const SizedBox(height: 30),
          Center(
            child: Text(
              '© 2025 HIRENT. All rights reserved.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget settingsTileSwitch({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
