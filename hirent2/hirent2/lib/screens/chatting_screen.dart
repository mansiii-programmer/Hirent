import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final List<Map<String, dynamic>> chatList = const [
    {
      'name': 'Provider 1',
      'message': 'Let\'s discuss about the cleaning task',
      'time': 'about 16 hours ago',
      'unreadCount': 1,
    },
    {
      'name': 'Provider 2',
      'message': 'Let\'s discuss about the babysitting task',
      'time': 'about 14 hours ago',
      'unreadCount': 2,
    },
    {
      'name': 'Provider 3',
      'message': 'Let\'s discuss about the gardening task',
      'time': 'about 11 hours ago',
      'unreadCount': 1,
    },
    {
      'name': 'Provider 4',
      'message': 'Let\'s discuss about the cooking task',
      'time': 'about 16 hours ago',
      'unreadCount': 2,
    },
    {
      'name': 'Provider 5',
      'message': 'Let\'s discuss about the pet care task',
      'time': 'about 10 hours ago',
      'unreadCount': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF6),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF1F3F2),
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(name: chat['name']),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text(chat['name'].substring(0, 1),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chat['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(chat['message'],
                                  style:
                                      const TextStyle(color: Colors.black87)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(chat['time'],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            if (chat['unreadCount'] > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  chat['unreadCount'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Chat Detail Screen ---

// Inside same file with ChatScreen

class ChatDetailScreen extends StatelessWidget {
  final String name;

  const ChatDetailScreen({super.key, required this.name});

  final List<Map<String, dynamic>> messages = const [
    {
      'from': 'P',
      'message': 'Yes, I can help with cooking. When would you need it?',
      'time': 'about 11 hours ago',
    },
    {
      'from': 'Y',
      'message': 'Hi, I\'m interested in pet care services. Are you available?',
      'time': 'about 3 hours ago',
    },
    {
      'from': 'P',
      'message': 'Yes, I can help with tutoring. When would you need it?',
      'time': 'about 4 hours ago',
    },
    {
      'from': 'Y',
      'message': 'Hi, I\'m interested in shopping services. Are you available?',
      'time': 'about 17 hours ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAF6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40), // optional spacing to replace AppBar
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isSender = msg['from'] == 'Y';
                return Column(
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isSender
                            ? const Color(0xFFF3F3F1) // lighter shade
                            : const Color(0xFFEFEFEA), // slightly darker
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['message'],
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        msg['time'],
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const ChatInputFieldStyled(),
        ],
      ),
    );
  }
}

class ChatInputFieldStyled extends StatelessWidget {
  const ChatInputFieldStyled({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAF6),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F3F2),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}