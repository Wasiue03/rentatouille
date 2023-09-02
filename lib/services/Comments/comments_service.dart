import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCommentReply(String commentId, String replyText) async {
    try {
      await _firestore.collection('Comments').doc(commentId).update({
        'replies': FieldValue.arrayUnion([replyText]),
      });
    } catch (e) {
      print('Error submitting reply: $e');
      throw e;
    }
  }

  Future<void> addComment(String postId, String commentText) async {
    try {
      await _firestore.collection('Comments').add({
        'postId': postId, // Include the postId in the comment data
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'replies': [],
      });
    } catch (e) {
      print('Error submitting comment: $e');
      throw e;
    }
  }

  static Stream<QuerySnapshot> getCommentsStream(String postId) {
    return FirebaseFirestore.instance
        .collection('Comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();

    if (now.difference(dateTime).inDays > 0) {
      return DateFormat('MMM d, yyyy').format(dateTime);
    } else {
      return DateFormat.jm().format(dateTime);
    }
  }
}
