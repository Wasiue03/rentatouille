import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentatouille/views/Comments/comment_screen.dart';
import 'package:rentatouille/views/news/news.dart';
import 'package:rentatouille/views/seller_screens/seller_post.dart';
import 'package:rentatouille/views/transaction/transaction_history.dart';
import 'package:rentatouille/views/userProfile/Profile.dart';

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

  void _deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('SellPosts')
          .doc(postId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted successfully')),
      );
    } catch (e) {
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
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Dashboard buttons
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.person, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(),
                      ),
                    );
                    // Navigate to user profile screen
                  },
                ),
                IconButton(
                  icon: Icon(Icons.money, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistoryScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellPosts()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.newspaper, color: Colors.black),
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
          // List of posts
          Expanded(
            child: Container(
              color: Colors.white,
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

                      final postRating = post['renterRating'] ?? 0.0;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.black),
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
                                      color: Colors.black,
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
                                      'Answers',
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Rating: $postRating', // Display the rating
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 41, 181, 46),
                                    fontSize: 15,
                                  ),
                                ),
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
