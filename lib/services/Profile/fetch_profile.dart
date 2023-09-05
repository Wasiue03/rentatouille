// user_profile_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/UserProfile/user_profile.dart';

class UserProfileService {
  Future<UserProfile?> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null; // No user signed in
    }

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('sellProperties')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        return UserProfile(
          uid: user.uid,
          displayName: data['displayName'] ?? '',
          email: data['email'] ?? '',
          profilePictureUrl: data['profilePictureUrl'] ?? '',
        );
      } else {
        return null; // User profile not found
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
