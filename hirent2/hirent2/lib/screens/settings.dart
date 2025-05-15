import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
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
        title: Text('Settings'),
        leading: BackButton(),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
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
            leading: Icon(Icons.language),
            title: Text('Language'),
            trailing: Text('English', style: TextStyle(color: Colors.grey[600])),
            onTap: () {},
          ),
          SizedBox(height: 20),
          sectionTitle('Security'),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          settingsTileSwitch(
            icon: Icons.lock_outline,
            label: 'Two-Factor Authentication',
            value: twoFactorAuth,
            onChanged: (val) => setState(() => twoFactorAuth = val),
          ),
          SizedBox(height: 20),
          sectionTitle('App'),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('App Version'),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.grey[600])),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About HIRENT'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & Support'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              '© 2025 HIRENT. All rights reserved.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold),
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
