import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitSellPropertyData({
    required String propertyDescription,
  }) async {
    try {
      await _firestore.collection('SellPosts').add({
        'propertyDescription': propertyDescription,
      });
    } catch (e) {
      print('Error submitting sell property data: $e');
      throw e;
    }
  }
}
