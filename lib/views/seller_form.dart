// import 'package:flutter/material.dart';

// import '../models/sell_props.dart';

// class SellScreen extends StatelessWidget {
//   final TextEditingController _propertyNameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _askingPriceController = TextEditingController();
//   final TextEditingController _propertyDescriptionController =
//       TextEditingController();

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 40, 39, 39),
//         title: Center(child: Text('Sell a Property')),
//       ),
//       body: Container(
//         color: Colors.black, // Set the background color to black
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Tell us about the property you want to sell',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white), // Set text color to white
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _propertyNameController,
//                   style: TextStyle(color: Colors.white), // Set field text color
//                   decoration: InputDecoration(
//                     labelText: 'Property Name',
//                     hintText: 'Any name of property',
//                     labelStyle:
//                         TextStyle(color: Colors.white), // Set label text color
//                     hintStyle:
//                         TextStyle(color: Colors.white), // Set hint text color
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _locationController,
//                   style: TextStyle(color: Colors.white), // Set field text color
//                   decoration: InputDecoration(
//                     labelText: 'Location',
//                     hintText: 'Where it is located',
//                     labelStyle:
//                         TextStyle(color: Colors.white), // Set label text color
//                     hintStyle:
//                         TextStyle(color: Colors.white), // Set hint text color
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _askingPriceController,
//                   style: TextStyle(color: Colors.white), // Set field text color
//                   decoration: InputDecoration(
//                     labelText: 'Monthly Price',
//                     hintText: 'Enter Desired Price',
//                     labelStyle:
//                         TextStyle(color: Colors.white), // Set label text color
//                     hintStyle:
//                         TextStyle(color: Colors.white), // Set hint text color
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _propertyDescriptionController,
//                   style: TextStyle(color: Colors.white), // Set field text color
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                     labelText: 'Property Description',
//                     hintText: 'Tell us about the property and architecture',
//                     labelStyle:
//                         TextStyle(color: Colors.white), // Set label text color
//                     hintStyle:
//                         TextStyle(color: Colors.white), // Set hint text color
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       submitSellPropertyData(
//                         propertyName: _propertyNameController.text,
//                         location: _locationController.text,
//                         askingPrice: double.parse(_askingPriceController.text),
//                         propertyDescription:
//                             _propertyDescriptionController.text,
//                       );
//                     },
//                     child: Text('Submit'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           Colors.red, // Set button background color
//                       foregroundColor: Colors.white, // Set button text color
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
