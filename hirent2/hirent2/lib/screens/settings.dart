import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final saved = await SharedPrefService.getBool('notifications');
    if (saved != null) {
      setState(() => notifications = saved);
    }
  }

  Future<void> _updateNotificationPreference(bool value) async {
    setState(() => notifications = value);
    await SharedPrefService.setBool('notifications', value);
  }

  Future<void> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/otp/otp/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to send OTP: ${data['message']}");
    }
  }

  Future<void> changePassword(
      String email, String otp, String newPassword) async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:8000/changepassword/changepassword/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp': otp,
        'new_password': newPassword,
      }),
    );
    print(email);
    print(otp);
    print(newPassword);

    final data = jsonDecode(response.body);
    print(data);

    if (response.statusCode != 200) {
      throw Exception("Password change failed: ${data['message']}");
    }
  }

  void showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter your Email"),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: "example@gmail.com"),
        ),
        actions: [
          TextButton(
            child: const Text("Send OTP"),
            onPressed: () async {
              final email = emailController.text.trim();
              try {
                await sendOtp(email);
                Navigator.of(context, rootNavigator: true)
                    .pop(); // Close email dialog
                await showOtpDialog(context, email); // Now open OTP dialog
              } catch (e) {
                Navigator.of(context, rootNavigator: true).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.toString()}")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> showOtpDialog(BuildContext context, String email) async {
    otpController.clear();
    newPasswordController.clear();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Verify OTP"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(hintText: "Enter OTP"),
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(hintText: "New Password"),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Change Password"),
            onPressed: () async {
              final otp = otpController.text.trim();
              final newPassword = newPasswordController.text.trim();
              Navigator.of(context, rootNavigator: true).pop();
              try {
                await changePassword(email, otp, newPassword);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Password changed successfully")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.toString()}")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

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
            onChanged: (val) => _updateNotificationPreference(val),
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
            onTap: () => showEmailDialog(context),
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
