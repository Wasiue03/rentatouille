import 'package:flutter/material.dart';
import 'package:rentatouille/views/rent_form.dart';
import 'package:rentatouille/views/rent_register.dart';
import 'package:rentatouille/views/seller_form.dart';
import 'package:rentatouille/views/seller_register.dart';

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
                  // Navigate to the next screen based on the selected option
                  if (_selectedOption == 'Rent') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RentRegisterPage()),
                    );
                  } else if (_selectedOption == 'Sell') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerRegisterPage()),
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
