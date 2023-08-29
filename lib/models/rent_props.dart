import 'package:cloud_firestore/cloud_firestore.dart';

void submitRentPropertyData({
  required String propertyName,
  required String location,
  required double monthlyRent,
  required String propertyDescription,
}) async {
  try {
    await FirebaseFirestore.instance.collection('rentProperties').add({
      'propertyName': propertyName,
      'location': location,
      'monthlyRent': monthlyRent,
      'propertyDescription': propertyDescription,
      // Add more fields if needed
    });
  } catch (e) {
    print('Error submitting rent property data: $e');
  }
}
