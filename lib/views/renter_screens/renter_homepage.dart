import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/Notifications/notification.dart';
import '../Comments/comment_screen.dart';
import '../news/news.dart';

class RenterHomeScreen extends StatefulWidget {
  @override
  _RenterHomeScreenState createState() => _RenterHomeScreenState();
}

class _RenterHomeScreenState extends State<RenterHomeScreen> {
  Map<String, bool> _interestedStatus = {};

  void _goToCommentsScreen(String postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(postId: postId),
      ),
    );
  }

  void _toggleInterest(String postId) {
    setState(() {
      if (_interestedStatus.containsKey(postId)) {
        _interestedStatus[postId] = !_interestedStatus[postId]!;
      } else {
        _interestedStatus[postId] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Renter Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.newspaper),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
                              ListTile(
                                title: Text(
                                  post['propertyName'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  post['location'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  post['propertyDescription'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      _goToCommentsScreen(postId);
                                    },
                                    icon: Icon(
                                      Icons.comment,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Replace 'SELLER_FCM_TOKEN' with the actual seller's FCM token
                                      String sellerFcmToken =
                                          'c8UAT70aQZS2Q94SU71FBN:APA91bFliczWwnAOCmyBOHqdZZ2u4T6An5RxzIeVZXny_ubE3u0WkzJHiN0TYPu2CNeGwZHUH82N9M-2bp5ywXvOuyz5IIeqPCAvKqVGoeamvHFp3ZBa37VFc9AdpHrCsyTUUw-E1vh4';

                                      // Send notification to the seller
                                      FirebaseApi().sendNotificationToSeller(
                                          sellerFcmToken);

                                      // Update the UI or set the state to indicate that the notification has been sent
                                      _toggleInterest(postId);
                                    },
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: _interestedStatus[postId] == true
                                          ? Text('Sent')
                                          : Text('Interest'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 18, 100, 21),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
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
