import 'package:flutter/material.dart';

import '../../models/rent_props.dart';

class RentScreen extends StatelessWidget {
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _monthlyRentController = TextEditingController();
  final TextEditingController _propertyDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 39, 39),
        title: Center(child: Text('Rent a Property')),
      ),
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us about the property you want to rent',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Set text color to white
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _propertyNameController,
                  style: TextStyle(color: Colors.white), // Set field text color
                  decoration: InputDecoration(
                    labelText: 'Property Name',

                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _locationController,
                  style: TextStyle(color: Colors.white), // Set field text color
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _monthlyRentController,
                  style: TextStyle(color: Colors.white), // Set field text color
                  decoration: InputDecoration(
                    labelText: 'Monthly Rent',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _propertyDescriptionController,
                  style: TextStyle(color: Colors.white), // Set field text color
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Property Description',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        // RentData(
                        //   propertyName: _propertyNameController.text,
                        //   location: _locationController.text,
                        //   monthlyRent:
                        //       double.parse(_monthlyRentController.text),
                        //   propertyDescription:
                        //       _propertyDescriptionController.text,
                        // );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Invalid input for Monthly Rent.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Set button background color
                      foregroundColor: Colors.white, // Set button text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
