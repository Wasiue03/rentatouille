import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentatouille/views/homepage.dart';
import 'package:rentatouille/views/landing_page.dart';
import 'package:rentatouille/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/Landing', // Set the initial route
      routes: {
        '/Landing': (context) => LandingScreen(),
        '/login': (context) => LoginPage(),
        '/homepage': (context) =>
            hoempage(), // Define the route for your homepage
      },
    );
  }
}
