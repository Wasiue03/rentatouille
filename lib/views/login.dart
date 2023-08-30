import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(
            context, '/homepage'); // Replace '/homepage' with your actual route
      }
      // User is logged in, navigate to a new screen.
    } catch (e) {
      print('Login error: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  style: TextStyle(color: Colors.white), // Set text color
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                    prefixIcon: Icon(Icons.email,
                        color: Colors.white), // Set icon color
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Set border color
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Set border color
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white), // Set text color
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                    prefixIcon:
                        Icon(Icons.lock, color: Colors.white), // Set icon color
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Set border color
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Set border color
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150, // Set the width of the button
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set background color
                    foregroundColor: Colors.white, // Set text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
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
