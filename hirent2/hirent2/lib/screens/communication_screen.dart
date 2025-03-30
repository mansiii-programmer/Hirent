import 'package:flutter/material.dart';

class ChatNegotiationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat & Negotiate"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // replace with actual chat data
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text("User ${index + 1}"),
                  subtitle: Text("Chat message example"),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // send message logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
