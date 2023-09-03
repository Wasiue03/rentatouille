import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentatouille/views/transaction/transaction_history.dart';

class RentPaymentForm extends StatefulWidget {
  @override
  _RentPaymentFormState createState() => _RentPaymentFormState();
}

class _RentPaymentFormState extends State<RentPaymentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tenantNameController;
  late TextEditingController _rentAmountController;

  @override
  void initState() {
    super.initState();
    _tenantNameController = TextEditingController();
    _rentAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _tenantNameController.dispose();
    _rentAmountController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final tenantName = _tenantNameController.text;
      final rentAmount = double.parse(_rentAmountController.text);

      // Create a Firestore reference to the "paymentRecords" collection
      final paymentCollection =
          FirebaseFirestore.instance.collection('paymentRecords');

      // Create a new payment record document in Firestore
      await paymentCollection.add({
        'tenantName': tenantName,
        'rentAmount': rentAmount,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Close the payment form screen and navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  void _viewTransactionHistory(BuildContext context) {
    // Navigate to the transaction history screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: TextFormField(
                  controller: _tenantNameController,
                  decoration: InputDecoration(
                    labelText: 'Tenant Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder
                        .none, // Remove TextFormField's default border
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a tenant name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16), // Add spacing between text fields
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: TextFormField(
                  controller: _rentAmountController,
                  decoration: InputDecoration(
                    labelText: 'Rent Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder
                        .none, // Remove TextFormField's default border
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a rent amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16), // Add spacing between text fields
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 16), // Add spacing between button and text
              TextButton(
                onPressed: () => _viewTransactionHistory(context),
                child: Text(
                  'View Transaction History',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
