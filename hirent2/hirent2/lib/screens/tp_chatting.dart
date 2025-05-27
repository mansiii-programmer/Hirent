import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// main screen
class TpChatScreen extends StatefulWidget {
  final String currentUser;

  const TpChatScreen({super.key, required this.currentUser});

  @override
  State<TpChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<TpChatScreen> {
  List<dynamic> allMessages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllMessages();
  }

  Future<void> fetchAllMessages() async {
    final url = Uri.parse('http://127.0.0.1:8000/chat/chat/partners/${widget.currentUser}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        allMessages = data;
        isLoading = false;
      });
    } else {
      print("Failed to fetch chat list: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  }

  String getTimeAgo(String isoTime) {
    final time = DateTime.parse(isoTime);
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
    final Map<String, Map<String, dynamic>> chatSummaries = {};

    for (var msg in allMessages) {
      final otherUser = msg['sender'] == widget.currentUser ? msg['receiver'] : msg['sender'];

      if (!chatSummaries.containsKey(otherUser)) {
        chatSummaries[otherUser] = {
          'name': otherUser,
          'message': msg['message'],
          'timestamp': msg['timestamp'],
          'unread': 0,
        };
      }

      if (msg['receiver'] == widget.currentUser && msg['is_read'] == false) {
        chatSummaries[otherUser]!['unread'] += 1;
      }
    }

    final chatList = chatSummaries.values.toList()
      ..sort((a, b) => DateTime.parse(b['timestamp']).compareTo(DateTime.parse(a['timestamp'])));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFAFAF8),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : chatList.isEmpty
              ? const Center(child: Text("No conversations found"))
              : ListView.separated(
                  itemCount: chatList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final chat = chatList[index];
                    return Container(
                      color: index % 2 == 0 ? Colors.white : const Color(0xFFF7FAFB),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFEDF1F3),
                          child: Text(
                            chat['name'][0].toUpperCase(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text(
                          chat['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(chat['message']),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTimeAgo(chat['timestamp']),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            if (chat['unread'] > 0)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  chat['unread'].toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                user1: widget.currentUser,
                                user2: chat['name'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

// chat page screen
class ChatPage extends StatefulWidget {
  final String user1;
  final String user2;

  const ChatPage({super.key, required this.user1, required this.user2});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    final url = Uri.parse('http://127.0.0.1:8000/chat/chat/history/${widget.user1}/${widget.user2}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        messages = data;
        isLoading = false;
      });
    } else {
      print("Failed to fetch messages: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  }

  String getTimeAgo(String isoTime) {
    final time = DateTime.parse(isoTime);
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
    final Map<String, Map<String, dynamic>> grouped = {};

    for (var msg in messages) {
      final otherUser = msg['sender'] == widget.user1 ? msg['receiver'] : msg['sender'];
      if (!grouped.containsKey(otherUser)) {
        grouped[otherUser] = {
          'name': otherUser,
          'message': msg['message'],
          'time': msg['timestamp'],
          'unread': 0,
        };
      }
      if (msg['receiver'] == widget.user1 && msg['is_read'] == false) {
        grouped[otherUser]!['unread'] += 1;
      }
    }

    final chatList = grouped.values.toList()
      ..sort((a, b) => DateTime.parse(b['time']).compareTo(DateTime.parse(a['time'])));

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      appBar: AppBar(
        title: Text(
          widget.user2,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: chatList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final msg = chatList[index];
                return Container(
                  color: index % 2 == 0 ? Colors.white : const Color(0xFFF7FAFB),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEDF1F3),
                      child: Text(
                        msg['name'][0].toUpperCase(),
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
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
