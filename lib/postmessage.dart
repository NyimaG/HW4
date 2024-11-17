import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostMessageWidget extends StatefulWidget {
  final String boardId; // The ID of the message board

  const PostMessageWidget({Key? key, required this.boardId}) : super(key: key);

  @override
  _PostMessageWidgetState createState() => _PostMessageWidgetState();
}

class _PostMessageWidgetState extends State<PostMessageWidget> {
  final TextEditingController _messageController = TextEditingController();
  bool _isPosting = false;

  Future<void> _postMessage() async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message cannot be empty')),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      await FirebaseFirestore.instance
          .collection('messageboards')
          .doc(widget.boardId) // The board's ID
          .collection('messages') // Messages subcollection
          .add({
        'text': _messageController.text.trim(),
        'user': user.email, // Use the logged-in user's email or display name
        'datetime': FieldValue.serverTimestamp(), // Use Firestore server time
      });

      _messageController.clear(); // Clear the input field after posting
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isPosting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Type your message',
            ),
          ),
        ),
        _isPosting
            ? CircularProgressIndicator()
            : IconButton(
                icon: Icon(Icons.send),
                onPressed: _postMessage,
              ),
      ],
    );
  }
}
