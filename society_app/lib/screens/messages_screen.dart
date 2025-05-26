import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': 1,
      'name': 'Sarah Johnson',
      'lastMessage': 'Is the coffee table still available?',
      'time': '2m ago',
      'unreadCount': 2,
      'isOnline': true,
      'avatar': 'SJ',
    },
    {
      'id': 2,
      'name': 'Mike Chen',
      'lastMessage': 'Thanks for the guitar lesson recommendation!',
      'time': '1h ago',
      'unreadCount': 0,
      'isOnline': false,
      'avatar': 'MC',
    },
    {
      'id': 3,
      'name': 'Emily Davis',
      'lastMessage': 'Can you deliver the desk to my apartment?',
      'time': '3h ago',
      'unreadCount': 1,
      'isOnline': true,
      'avatar': 'ED',
    },
    {
      'id': 4,
      'name': 'Tom Wilson',
      'lastMessage': 'Great meeting you at the block party!',
      'time': '1d ago',
      'unreadCount': 0,
      'isOnline': false,
      'avatar': 'TW',
    },
    {
      'id': 5,
      'name': 'Lisa Brown',
      'lastMessage': 'Do you still need help with moving?',
      'time': '2d ago',
      'unreadCount': 0,
      'isOnline': true,
      'avatar': 'LB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildConversationsList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new conversation
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messages',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Search messages
                },
                icon: const Icon(Icons.search),
                iconSize: 24,
              ),
              IconButton(
                onPressed: () {
                  // More options
                },
                icon: const Icon(Icons.more_vert),
                iconSize: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search conversations',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildConversationsList() {
    return ListView.builder(
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        return _buildConversationItem(conversation);
      },
    );
  }

  Widget _buildConversationItem(Map<String, dynamic> conversation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF009688),
              child: Text(
                conversation['avatar'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            if (conversation['isOnline'])
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                conversation['name'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              conversation['time'],
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                conversation['lastMessage'],
                style: TextStyle(
                  fontSize: 14,
                  color: conversation['unreadCount'] > 0
                      ? Colors.black87
                      : Colors.grey[600],
                  fontWeight: conversation['unreadCount'] > 0
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (conversation['unreadCount'] > 0)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  conversation['unreadCount'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          // Navigate to chat screen
          _openChatScreen(conversation);
        },
      ),
    );
  }

  void _openChatScreen(Map<String, dynamic> conversation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chat with ${conversation['name']}'),
        content: const Text('Chat functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
