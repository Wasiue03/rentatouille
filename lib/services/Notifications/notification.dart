import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
  }

  void sendNotificationToSeller(String sellerFCMToken) async {
    final String serverKey =
        'AAAAZd8_6z4:APA91bHqBwUSUsutZvRPEMHGlbTfapVUoxBzBdgInZ0oT1fuT7i97vWI5NTAArv4Zuj8RPKEoj9AEItp9__vMyDBJjU4bfqSolZNIgPjCfCYGEN_zE83A2IEbPQJT3MAlm7plsBbr4Xm'; // Replace with your Firebase server key
    final String senderID = '437537205054'; // Replace with your sender ID
    final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notificationMessage = {
      'notification': {
        'title': 'Buyer is Interested',
        'body': 'A buyer is interested in your product.',
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'buyer_interest': 'true',
      },
      'to': sellerFCMToken,
    };

    final response = await http.post(
      Uri.parse(fcmEndpoint), // Corrected Uri.parse
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(notificationMessage),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.statusCode}');
    }
  }
}
