// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;
//   late TextEditingController _confirmPasswordController;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//   }

//   void _register() async {
//     try {
//       if (_passwordController.text != _confirmPasswordController.text) {
//         // Show an error message or Snackbar indicating password mismatch.
//         return;
//       }

//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       // User is registered and logged in, navigate to a new screen.
//     } catch (e) {
//       print('Registration error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: Container(
//         color: Colors.black,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFormField(
//                     controller: _emailController,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       labelStyle: TextStyle(color: Colors.white),
//                       hintStyle: TextStyle(color: Colors.white),
//                       prefixIcon: Icon(Icons.email, color: Colors.white),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       labelStyle: TextStyle(color: Colors.white),
//                       hintStyle: TextStyle(color: Colors.white),
//                       prefixIcon: Icon(Icons.lock, color: Colors.white),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     obscureText: true,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFormField(
//                     controller: _confirmPasswordController,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       labelStyle: TextStyle(color: Colors.white),
//                       hintStyle: TextStyle(color: Colors.white),
//                       prefixIcon: Icon(Icons.lock, color: Colors.white),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     obscureText: true,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: 150,
//                   child: ElevatedButton(
//                     onPressed: _register, // Call the _register function
//                     child: Text('Register'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
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
import 'package:flutter/material.dart';
import 'package:rentatouille/views/rent_register.dart';
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
                      MaterialPageRoute(builder: (context) => RentScreen()),
                    );
                  } else if (_selectedOption == 'Sell') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellScreen()),
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
