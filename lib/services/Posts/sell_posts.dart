import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitSellPropertyData({
    required String propertyDescription,
    String? imageUrl,
  }) async {
    try {
      await _firestore.collection('SellPosts').add({
        'propertyDescription': propertyDescription,
        'imageUrl': imageUrl, // Store the image URL
      });
    } catch (e) {
      print('Error submitting sell property data: $e');
      throw e;
    }
  }
}
