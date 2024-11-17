import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  Future<Map<String, dynamic>> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Fetch user document from Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception('User data not found');
    }

    return userDoc.data()!; // Return user data as a Map
  }

  Future<void> _editField(
      BuildContext context, String field, String currentValue) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final TextEditingController controller =
        TextEditingController(text: currentValue);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Enter new $field'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .update({field: controller.text.trim()});
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$field updated successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating $field: $e')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No user data found.'));
          }

          final userData = snapshot.data!;

          return ListView(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('First Name'),
                subtitle: Text(userData['firstname'] ?? 'N/A'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editField(
                        context, 'firstname', userData['firstname'] ?? '');
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Last Name'),
                subtitle: Text(userData['lastname'] ?? 'N/A'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editField(
                        context, 'firstname', userData['firstname'] ?? '');
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text('Role'),
                subtitle: Text(userData['role'] ?? 'N/A'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editField(
                        context, 'firstname', userData['firstname'] ?? '');
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
