import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sellProperty({
    required String propertyName,
    required String location,
  }) async {
    try {
      // Store rent property data
      await FirebaseFirestore.instance.collection('sellProperties').add({
        'propertyName': propertyName,
        'location': location,

        // Add more fields if needed
      });

      // User is registered and logged in, navigate to a new screen.
    } catch (e) {
      print('Registration error: $e');
    }
  }
}
