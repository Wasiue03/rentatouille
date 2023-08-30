import 'package:flutter/material.dart';

import '../services/sell_posts.dart';

class SellPosts extends StatefulWidget {
  @override
  _SellPostsState createState() => _SellPostsState();
}

class _SellPostsState extends State<SellPosts> {
  final TextEditingController _propertyDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _propertyDescriptionController.text =
        'Tell us about the property and architecture'; // Initial text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 39, 39),
        title: Center(child: Text('Sell a Property')),
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
                  'Tell us about the property you want to sell',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Set text color to white
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _propertyDescriptionController,
                  style: TextStyle(color: Colors.white), // Set field text color
                  maxLines: 10, // Set number of lines
                  decoration: InputDecoration(
                    labelText: 'Property Description',
                    labelStyle:
                        TextStyle(color: Colors.white), // Set label text color
                    hintStyle:
                        TextStyle(color: Colors.white), // Set hint text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseService firebaseService = FirebaseService();
                      await firebaseService.submitSellPropertyData(
                        propertyDescription:
                            _propertyDescriptionController.text,
                      );
                    },
                    child: Text('Post'),
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
