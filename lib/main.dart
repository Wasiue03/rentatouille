import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rentatouille/services/notification.dart';
import 'package:rentatouille/views/renter_screens/renter_homepage.dart';
import 'package:rentatouille/views/landing_page.dart';
import 'package:rentatouille/views/login.dart';
import 'package:rentatouille/views/seller_screens/seller_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
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
        '/renterHomepage': (context) => RenterHomeScreen(),
        '/sellerHomepage': (context) => SellerHomeScreen(),
      },
    );
  }
}
