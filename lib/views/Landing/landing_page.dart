import 'package:flutter/material.dart';
import 'package:rentatouille/views/Register/register.dart';
import '../../services/Provider/auth_provider.dart';
import '../Login/login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Rentatouille')),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage('assets/images/AI_Generated_Image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 80),
              Text(
                "Welcome To Rentatouille",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 190,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellerRegisterPage()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add some space
              _buildGoogleLoginButton(context), // Google login button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        // Call your signInWithGoogle method and handle the result
        try {
          await AuthProvider().signInWithGoogle();
          // Once Google Sign-In is successful, you can navigate to the appropriate screen.
        } catch (e) {
          // Handle any errors that might occur during Google Sign-In.
          print("Error signing in with Google: $e");
        }
      },
      icon: Image.asset(
        'assets/images/google.png', // Replace with your Google logo image path
        height: 24,
        width: 24,
      ),
      label: Text(
        "Sign in with Google",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color
        foregroundColor: Colors.black, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
