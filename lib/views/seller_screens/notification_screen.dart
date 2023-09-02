import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this package to format timestamps

import '../../models/notify_model.dart'; // Import your notification model

class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications;

  NotificationScreen({required this.notifications});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final formattedTimestamp =
                DateFormat.yMMMd().add_jm().format(notification.timestamp);

            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(
                formattedTimestamp,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Handle tapping on a notification (e.g., navigate to a specific screen)
              },
            );
          },
        ),
      ),
    );
  }
}
