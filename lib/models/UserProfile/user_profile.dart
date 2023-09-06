import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String displayName;
  final String email;
  final String profilePictureUrl;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.profilePictureUrl,
  });
}
