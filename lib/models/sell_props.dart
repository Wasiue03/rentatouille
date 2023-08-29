import 'package:cloud_firestore/cloud_firestore.dart';

void submitSellPropertyData({
  required String propertyName,
  required String location,
  required double askingPrice,
  required String propertyDescription,
}) async {
  try {
    await FirebaseFirestore.instance.collection('sellProperties').add({
      'propertyName': propertyName,
      'location': location,
      'askingPrice': askingPrice,
      'propertyDescription': propertyDescription,
      // Add more fields if needed
    });
  } catch (e) {
    print('Error submitting sell property data: $e');
  }
}
