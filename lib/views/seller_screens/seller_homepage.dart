import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentatouille/models/notifications/notify_model.dart';
import 'package:rentatouille/views/Comments/comment_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rentatouille/views/news/news.dart';
import 'package:rentatouille/views/seller_screens/seller_form.dart';

import '../../services/Notifications/notification_service.dart';
import 'notification_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
    _notificationService.initialize();
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;

      if (title != null && body != null) {
        _notificationService.showNotification(title, body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      _notificationService.cancelNotification(0);
    });
  }

  void _goToCommentsScreen(String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: postId),
      ),
    );
  }

  void _deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('SellPosts')
          .doc(postId)
          .delete();
      // You can also delete any related data or images associated with the post if needed.

      // Show a success message or handle further actions.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted successfully')),
      );
    } catch (e) {
      // Handle any errors that may occur during the deletion process.
      print('Error deleting post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellPosts()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationScreen(notifications: notifications)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.newspaper, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('SellPosts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final posts = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index].data() as Map<String, dynamic>;

                      final propertyDescription = post['propertyDescription'];
                      final postId = posts[index].id;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.black,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (propertyDescription != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    propertyDescription,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      _goToCommentsScreen(postId);
                                    },
                                    icon:
                                        Icon(Icons.comment, color: Colors.red),
                                    label: Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _deletePost(postId);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
