import 'package:flutter/material.dart';

class RentPayment extends StatelessWidget {
  final String tenantName;
  final double rentAmount;

  RentPayment({
    required this.tenantName,
    required this.rentAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tenant Name: $tenantName'),
            Text('Rent Amount: \$${rentAmount.toStringAsFixed(2)}'),
            // Add payment-related UI and logic here
          ],
        ),
      ),
    );
  }
}
