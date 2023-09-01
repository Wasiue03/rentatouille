import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> rentProperty({
    required String propertyName,
    required String location,
    required double monthlyRent,
    required String propertyDescription,
    required String userId,
  }) async {
    try {
      // Store rent property data
      await FirebaseFirestore.instance.collection('rentProperties').add({
        'propertyName': propertyName,
        'location': location,
        'monthlyRent': monthlyRent,
        'propertyDescription': propertyDescription,
        // Add more fields if needed
      });

      // User is registered and logged in, navigate to a new screen.
    } catch (e) {
      print('Registration error: $e');
    }
  }
}
