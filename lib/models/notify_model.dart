import 'package:flutter_app_badger/flutter_app_badger.dart';

class NotificationModel {
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
  });
}

List<NotificationModel> notifications = [];

// Inside your NotificationService class or wherever you handle incoming messages
void handleIncomingMessage(String title, String body) {
  final newNotification = NotificationModel(
    title: title,
    body: body,
    timestamp: DateTime.now(),
  );
  notifications.add(newNotification);

  // Update the notification count badge
  FlutterAppBadger.updateBadgeCount(notifications.length);
}
