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

      final paymentCollection =
          FirebaseFirestore.instance.collection('paymentRecords');

      await paymentCollection.add({
        'tenantName': tenantName,
        'rentAmount': rentAmount,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);
    }
  }

  void _viewTransactionHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Rent Payment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _tenantNameController,
                  decoration: InputDecoration(
                    labelText: 'Tenant Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a tenant name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _rentAmountController,
                  decoration: InputDecoration(
                    labelText: 'Rent Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => _viewTransactionHistory(context),
                  child: Text(
                    'View Transaction History',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
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
