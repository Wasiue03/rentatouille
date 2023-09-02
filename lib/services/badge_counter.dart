import 'package:flutter/services.dart';

class BadgeCounter {
  static const MethodChannel _channel = MethodChannel('badge_counter');

  static Future<void> setBadgeCount(int count) async {
    try {
      await _channel.invokeMethod('setBadgeCount', {'count': count});
    } catch (e) {
      print('Error setting badge count: $e');
    }
  }

  static Future<void> clearBadgeCount() async {
    try {
      await _channel.invokeMethod('clearBadgeCount');
    } catch (e) {
      print('Error clearing badge count: $e');
    }
  }
}
