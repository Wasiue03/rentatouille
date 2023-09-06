import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentatouille/models/Renter/rent_props.dart';
import 'package:rentatouille/views/renter_screens/renter_homepage.dart';

import '../../models/User_Auth/user_auth.dart';
import '../../services/Provider/auth_provider.dart';

class RentRegisterPage extends StatefulWidget {
  final UserType userType; // Define the userType parameter

  RentRegisterPage({required this.userType}); // Constructor

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RentRegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _propertyNameController;
  late TextEditingController _locationController;
  late TextEditingController _monthlyRentController;
  late TextEditingController _propertyDescriptionController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _propertyNameController = TextEditingController();
    _locationController = TextEditingController();
    _monthlyRentController = TextEditingController();
    _propertyDescriptionController = TextEditingController();
  }

  void _register() async {
    try {
      FirebaseService firebaseService = FirebaseService();

      if (_confirmPasswordController.text != _passwordController.text) {
        debugPrint("Password does not Match!");
        return;
      }

      UserCredential userCredential = await AuthProvider.register(
        context,
        _passwordController.text,
        _emailController.text,
        widget.userType,
      );

      await firebaseService.rentProperty(
        propertyName: _propertyNameController.text,
        location: _locationController.text,
        monthlyRent: double.parse(_monthlyRentController.text),
        propertyDescription: _propertyDescriptionController.text,
        userId: userCredential.user!.uid,
      );

      // Navigate to a new screen after successful registration.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RenterHomeScreen(),
        ),
      );
    } catch (e) {
      print('Registration error: $e');
      // Display a user-friendly error message to the user on the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
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
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                SizedBox(height: 10),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _locationController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.location_on, color: Colors.white),
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
                    controller: _monthlyRentController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Monthly Rent',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _propertyDescriptionController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Property Description',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.description, color: Colors.white),
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
                SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _register, // Call the _register function
                    child: Text('Register'),
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
      ),
    );
  }
}
