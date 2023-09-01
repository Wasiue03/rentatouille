import 'package:flutter/material.dart';
import 'package:rentatouille/views/renter_screens/rent_form.dart';
import 'package:rentatouille/views/renter_screens/rent_register.dart';
import 'package:rentatouille/views/renter_screens/renter_homepage.dart';
import 'package:rentatouille/views/seller_screens/seller_register.dart';

import '../models/user_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedOption = 'Rent'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 39, 39),
        title: Center(child: Text('Registration')),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you here looking to...',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Rent a Property',
                ),
                textColor: Colors.white,
                leading: Radio(
                  activeColor: Colors.red,
                  fillColor: MaterialStateProperty.all(Colors.red),
                  value: 'Rent',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Sell a Property'),
                textColor: Colors.white,
                leading: Radio(
                  fillColor: MaterialStateProperty.all(Colors.red),
                  value: 'Sell',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set the border radius here
                  ),
                ),
                onPressed: () {
                  // Determine the user type based on the selected option
                  UserType userType = _selectedOption == 'Rent'
                      ? UserType.renter
                      : UserType.seller;

                  // Navigate to the registration page and pass the user type as an argument
                  if (_selectedOption == 'Rent') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RentRegisterPage(userType: userType),
                      ),
                    );
                  } else if (_selectedOption == 'Sell') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SellerRegisterPage(userType: userType),
                      ),
                    );
                  }
                },
                child: Text(
                  'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
