import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final List<Map<String, dynamic>> messages = [
    {
      'name': 'Seeker 1',
      'message': 'Let\'s discuss about the cleaning task',
      'time': DateTime.now().subtract(Duration(hours: 19)),
      'unread': 0,
    },
    {
      'name': 'Seeker 2',
      'message': 'Let\'s discuss about the babysitting task',
      'time': DateTime.now().subtract(Duration(hours: 21)),
      'unread': 0,
    },
    {
      'name': 'Seeker 3',
      'message': 'Let\'s discuss about the gardening task',
      'time': DateTime.now().subtract(Duration(hours: 4)),
      'unread': 1,
    },
    {
      'name': 'Seeker 4',
      'message': 'Let\'s discuss about the cooking task',
      'time': DateTime.now().subtract(Duration(hours: 11)),
      'unread': 1,
    },
    {
      'name': 'Seeker 5',
      'message': 'Let\'s discuss about the pet care task',
      'time': DateTime.now().subtract(Duration(hours: 8)),
      'unread': 2,
    },
  ];

  ChatPage({super.key});

  String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inHours >= 1) {
      return 'about ${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return 'about ${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    }
    return 'just now';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                filled: true,
                fillColor: const Color(0xFFEFF1F3),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isEven = index % 2 == 0;
                return Container(
                  color: isEven ? Colors.white : const Color(0xFFF7FAFB),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEDF1F3),
                      child: Text(
                        msg['name'][0],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      msg['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(msg['message']),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getTimeAgo(msg['time']),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        if (msg['unread'] > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              msg['unread'].toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {},
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
