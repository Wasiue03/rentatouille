import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import '../../services/Posts/sell_posts.dart';

class SellPosts extends StatefulWidget {
  @override
  _SellPostsState createState() => _SellPostsState();
}

class _SellPostsState extends State<SellPosts> {
  final TextEditingController _propertyDescriptionController =
      TextEditingController();
  File? _image; // Variable to store the selected image

  @override
  void initState() {
    super.initState();
    _propertyDescriptionController.text =
        'Tell us about the property and architecture'; // Initial text
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload the image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_image != null) {
      try {
        final firebase_storage.Reference storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(
                  'property_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
                );
        await storageRef.putFile(_image!);
        final String downloadURL = await storageRef.getDownloadURL();
        return downloadURL;
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
    return null;
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
                    color: Colors.white,
                  ), // Set text color to white
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
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
                      // Upload the image first and get its download URL
                      final imageUrl = await _uploadImage();

                      // Now, you can store the imageUrl and property description in Firestore
                      FirebaseService firebaseService = FirebaseService();
                      await firebaseService.submitSellPropertyData(
                        propertyDescription:
                            _propertyDescriptionController.text,
                        imageUrl: imageUrl,
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
