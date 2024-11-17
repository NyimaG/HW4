import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'boarddetails.dart';
import 'login.dart';

class MessageBoardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Boards'),
      ),
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
              leading: Icon(Icons.message),
              title: Text('Chat Boards'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageBoardsPage()));
                //Navigator.pushNamed(context, '/mboard.dart'); // Navigate to Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageBoardsPage()));
                //Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageBoardsPage()));
                //Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                // Handle Logout
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                //Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messageboards') // The Firestore collection
            .orderBy('name') // Order boards alphabetically by name
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No message boards available.'));
          }

          final boards = snapshot.data!.docs;

          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              final board = boards[index];
              return ListTile(
                leading: board['icon'] != null
                    ? Image.network(
                        board['icon'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.group), // Default icon if no iconUrl
                title: Text(board['name']),
                subtitle: Text(board['about']),
                onTap: () {
                  // Navigate to the message board details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageBoardDetailsPage(
                        boardId: board.id,
                        boardName: board['name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
