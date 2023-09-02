import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentatouille/services/Notifications/notification.dart';
import 'package:rentatouille/views/renter_screens/renter_homepage.dart';
import 'package:rentatouille/views/Landing/landing_page.dart';
import 'package:rentatouille/views/Login/login.dart';
import 'package:rentatouille/views/seller_screens/seller_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/Landing', // Set the initial route
      routes: {
        '/Landing': (context) => const LandingScreen(),
        '/login': (context) => LoginPage(),
        '/renterHomepage': (context) => RenterHomeScreen(),
        '/sellerHomepage': (context) => SellerHomeScreen(),
      },
    );
  }
}
