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
                ChatBubble(
                    isSender: false,
                    message:
                        'Hi, Mr. Sharma! I can design your poster in 2 days. Please share details',
                    senderAvatarUrl: 'https://www.example.com/avatar1.jpg'),
                ChatBubble(
                    isSender: true,
                    message:
                        'Hi! Need a 1080x1920 real estate poster (blue & white). Budget ₹2,500.',
                    senderAvatarUrl: 'https://www.example.com/avatar2.jpg'),
                ChatBubble(
                    isSender: false,
                    message:
                        'Got it! Send logo & text. Draft by tomorrow 5 PM. Payment via UPI?',
                    senderAvatarUrl: 'https://www.example.com/avatar1.jpg'),
                ChatBubble(
                    isSender: true,
                    message: 'Yes, payment after approval.',
                    senderAvatarUrl: 'https://www.example.com/avatar2.jpg'),
                ChatBubble(
                    isSender: false,
                    message: 'Great! Will update you soon.',
                    senderAvatarUrl: 'https://www.example.com/avatar1.jpg'),
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
  final String senderAvatarUrl;

  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.senderAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSender ? Colors.purple[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSender)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(senderAvatarUrl),
                  radius: 18,
                ),
              ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (isSender)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(senderAvatarUrl),
                  radius: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

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
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
