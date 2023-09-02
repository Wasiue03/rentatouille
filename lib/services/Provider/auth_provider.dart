import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/User_Auth/user_auth.dart';
import '../../views/renter_screens/renter_homepage.dart';
import '../../views/seller_screens/seller_homepage.dart';

class AuthProvider {
  static final _auth = FirebaseAuth.instance;
  static Future<UserCredential> register(
    BuildContext context,
    String password,
    String email,
    UserType userType, // This parameter represents the user's choice
  ) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successfully creating a user, you can store their user type
      // in your database, such as Firebase Firestore, using their UID.
      // Here's a general example of how you might do that:

      // Create a reference to the user's document in Firestore
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.user!.uid);

      // Set the user type in the document
      await userDoc.set({
        'userType': userType.toString(), // Store userType as a string
        // Add other user registration data here if needed
      });

      // Send email verification
      await user.user!.sendEmailVerification();

      return user;
    } on FirebaseAuthException catch (e) {
      // Handle registration errors
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      throw e; // Rethrow the exception to handle it elsewhere if needed.
    } catch (e) {
      debugPrint("Error in Auth Provider");
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user role (you may have a function for this)
      final UserType userType = getUserRole(creds.user!.uid);

      // Navigate based on the user's role
      handlePostLoginNavigation(
          context,
          UserAuth(
            id: creds.user!.uid,
            email: creds.user!.email!,
            userType: userType,
          ));
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      // ...
    } catch (e) {
      debugPrint("Error in Auth Provider");
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static UserType getUserRole(String uid) {
    // Implement a method to fetch the user's role based on their UID
    // You may use Firebase Firestore, Realtime Database, or any other method
    // ...
    return UserType.renter; // Replace with actual logic
  }

  static void handlePostLoginNavigation(BuildContext context, UserAuth user) {
    if (user.userType == UserType.renter) {
      // Navigate to the RenterHomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RenterHomeScreen()),
      );
    } else if (user.userType == UserType.seller) {
      // Navigate to the SellerHomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SellerHomeScreen()),
      );
    }
  }
}
