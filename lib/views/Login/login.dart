import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<String> getUserType(String uid) async {
    try {
      // Create a reference to the user's document in Firestore
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Get the document snapshot
      DocumentSnapshot docSnapshot = await userDoc.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Extract and return the userType from the document data
        return docSnapshot['userType'];
      } else {
        // Handle the case where the document doesn't exist
        print('User document does not exist for UID: $uid');
        return 'unknown';
      }
    } catch (e) {
      // Handle any errors that may occur while fetching the userType
      print('Error fetching userType: $e');
      return 'unknown';
    }
  }

  void _login() async {
    try {
      // Attempt to sign in with the provided email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if the sign-in was successful
      if (userCredential.user != null) {
        // Retrieve the user's userType from Firestore
        String userType = await getUserType(userCredential.user!.uid);

        // Compare the userType to determine the role of the user
        if (userType == 'UserType.seller') {
          // Navigate to the seller's home page
          Navigator.pushReplacementNamed(context, '/sellerHomepage');
        } else if (userType == 'UserType.renter') {
          // Navigate to the renter's home page
          Navigator.pushReplacementNamed(context, '/renterHomepage');
        } else {
          // Handle the case where userType is not recognized
          print('Unknown userType: $userType');
        }
      }
    } catch (e) {
      // Handle login errors
      print('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
