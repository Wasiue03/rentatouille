import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../services/comments_service.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;

  CommentsScreen({required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();
  late Stream<QuerySnapshot> _commentsStream;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _commentsStream = FirebaseService.getCommentsStream(widget.postId);
  }

  void _submitReply(String commentId) async {
    print('Submitting reply to comment with ID: $commentId');
    final replyText = _replyController.text;
    if (replyText.isNotEmpty) {
      await _firebaseService.addCommentReply(commentId, replyText);
      _replyController.clear();
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();

    if (now.difference(dateTime).inDays > 0) {
      return DateFormat('MMM d, yyyy').format(dateTime);
    } else {
      return DateFormat.jm().format(dateTime);
    }
  }

  void _submitComment() async {
    final commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      await _firebaseService.addComment(
          widget.postId, commentText); // Include widget.postId as the postId
      _commentController.clear();
    }
  }

  void _goToCommentsScreen(String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: postId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: StreamBuilder<QuerySnapshot>(
                stream: _commentsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final comments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment =
                          comments[index].data() as Map<String, dynamic>;
                      final commentText = comment['commentText'];
                      final timestamp = comment['timestamp'] as Timestamp;
                      final commentId = comments[index].id;

                      return ListTile(
                        title: Text(
                          commentText,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          _formatTimestamp(timestamp),
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.reply, color: Colors.white),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Reply to Comment'),
                                content: TextFormField(
                                  controller: _replyController,
                                  decoration: InputDecoration(
                                    labelText: 'Reply',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _submitReply(commentId);
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a Comment',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _submitComment,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
