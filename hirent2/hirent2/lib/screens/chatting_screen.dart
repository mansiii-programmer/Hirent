import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                ChatBubble(isSender: false, message: 'Hello!'),
                ChatBubble(isSender: true, message: 'Hey there!'),
                ChatBubble(isSender: false, message: 'How are you?'),
                ChatBubble(isSender: true, message: 'I am good, what about you?'),
                ChatBubble(isSender: false, message: 'Doing great!'),
                ChatBubble(isSender: true, message: 'Awesome!'),
              ],
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;

  const ChatBubble({super.key, required this.isSender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSender ? Colors.purple[300] : Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions, color: Colors.white54),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.purpleAccent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
