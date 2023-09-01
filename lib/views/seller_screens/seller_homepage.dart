import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentatouille/views/comment_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
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
        backgroundColor: Colors.black,
        title: Text(
          'Seller Home',
          style: TextStyle(
            fontSize: 24, // Increase the font size
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Handle the action for messages
              // Replace with your logic
            },
          ),
        ],
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
                    // Handle the action for adding posts
                    // Replace with your logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    // Handle the action for showing notifications
                    // Replace with your logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.newspaper, color: Colors.white),
                  onPressed: () {
                    // Handle the action for news
                    // Replace with your logic
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

                      final propertyName = post['propertyName'];
                      final location = post['location'];
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
                              if (propertyName != null)
                                ListTile(
                                  title: Text(
                                    propertyName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20, // Increase font size
                                      fontWeight: FontWeight.bold, // Bold text
                                    ),
                                  ),
                                  subtitle: Text(
                                    location ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
                                        fontSize: 16, // Increase font size
                                      ),
                                    ),
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
