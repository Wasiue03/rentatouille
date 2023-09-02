import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notifications');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Your Channel Name',
      'Your Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      // Enable showing a badge on the app icon
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
    );

    // Update the badge count when showing a new notification
    FlutterAppBadger.updateBadgeCount(1); // You can adjust the count as needed
  }

  // Method to cancel a notification
  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
