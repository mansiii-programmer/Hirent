import 'package:flutter/material.dart';
import 'package:hirent2/screens/your_tasks.dart';
import 'package:hirent2/screens/payment_method.dart'; // ✅ Make sure this file and class exist

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileSettingsPage(),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ishika Bhardwaaj",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.call, size: 14, color: Colors.black54),
                          SizedBox(width: 5),
                          Text("(+91) 7085126055",
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  settingsOption(Icons.person, "Your profile", context, null),
                  settingsOption(Icons.location_on, "Address", context, null),
                  settingsOption(
                      Icons.checklist, "Your tasks", context, YourTasksPage()),
                  settingsOption(Icons.payment, "Payment Methods", context,
                      PaymentMethodPage()), // ✅ Connected
                  settingsOption(Icons.settings, "Settings", context, null),
                  settingsOption(
                      Icons.account_balance_wallet, "Wallet", context, null),
                  settingsOption(Icons.security, "Security", context, null),
                  settingsOption(
                      Icons.group_add, "Invite Friends", context, null),
                  Divider(),
                  ListTile(
                    title: Text("Language"),
                    trailing: DropdownButton<String>(
                      value: "English",
                      onChanged: (String? newValue) {},
                      items: ["English", "Hindi"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    title: Text("Push Notifications"),
                    trailing: Switch(
                      value: true,
                      onChanged: (bool value) {},
                      activeColor: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsOption(
      IconData icon, String title, BuildContext context, Widget? page) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }
}
