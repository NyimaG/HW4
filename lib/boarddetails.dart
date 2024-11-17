import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'postmessage.dart';

class MessageBoardDetailsPage extends StatelessWidget {
  final String boardId; // The ID of the selected message board
  final String boardName;

  const MessageBoardDetailsPage({
    Key? key,
    required this.boardId,
    required this.boardName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(boardName)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile'); // Navigate to Profile
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(
                    context, '/settings'); // Navigate to Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Chat Boards'),
              onTap: () {
                Navigator.pushNamed(context, '/mboard'); // Navigate to Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                // Handle logout logic
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messageboards')
                  .doc(boardId)
                  .collection('messages')
                  .orderBy('datetime', descending: true) // Order by time
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true, // Show latest messages at the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message['text']),
                      subtitle: Text('By: ${message['user']}'),
                      trailing: message['datetime'] != null
                          ? Text(
                              (message['datetime'] as Timestamp)
                                  .toDate()
                                  .toString(),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          PostMessageWidget(boardId: boardId), // Widget for posting messages
        ],
      ),
    );
  }
}
