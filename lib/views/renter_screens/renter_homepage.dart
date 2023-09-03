import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/Notifications/notification.dart';
import '../../widgets/raring_feedback.dart';
import '../Comments/comment_screen.dart';
import '../news/news.dart';

class RenterHomeScreen extends StatefulWidget {
  const RenterHomeScreen({Key? key});

  @override
  _RenterHomeScreenState createState() => _RenterHomeScreenState();
}

class _RenterHomeScreenState extends State<RenterHomeScreen> {
  Map<String, double> _postRatings = {};
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
                      final postRating = _postRatings[postId] ?? 0.0;

                      return Stack(
                        children: [
                          Card(
                            color: Colors.black,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    post['propertyDescription'] ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    StarRatingWidget(
                                      initialRating: postRating,
                                      onRatingChanged: (newRating) {
                                        // Update the rating when the user interacts with the stars
                                        setState(() {
                                          _postRatings[postId] = newRating;
                                        });
                                        // You can also update the rating in your database here
                                        // using the newRating value and postId.
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 9, // Adjust the top position as needed
                            right: 8, // Adjust the right position as needed
                            child: ElevatedButton(
                              onPressed: () {
                                // Replace 'SELLER_FCM_TOKEN' with the actual seller's FCM token
                                String sellerFcmToken =
                                    'c8UAT70aQZS2Q94SU71FBN:APA91bFliczWwnAOCmyBOHqdZZ2u4T6An5RxzIeVZXny_ubE3u0WkzJHiN0TYPu2CNeGwZHUH82N9M-2bp5ywXvOuyz5IIeqPCAvKqVGoeamvHFp3ZBa37VFc9AdpHrCsyTUUw-E1vh4';

                                // Send notification to the seller
                                FirebaseApi()
                                    .sendNotificationToSeller(sellerFcmToken);

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
                                backgroundColor:
                                    const Color.fromARGB(255, 18, 100, 21),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
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
