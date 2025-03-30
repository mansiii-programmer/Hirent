import 'package:flutter/material.dart';

class ManageProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage & View Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 10),
            Text(
              "John Doe", // replace with actual user name
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8345B6)),
            ),
            Text("johndoe@email.com", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8345B6))), // replace with actual email
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
              onTap: () {
                // navigate to edit profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                // navigate to settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                // logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
