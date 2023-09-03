import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Container(
          color: Colors.black,
          child: TransactionList()), // Display the list of transactions
    );
  }
}

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('paymentRecords').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return Center(child: Text('No transaction history available.'));
        }

        return ListView.builder(
          itemCount: payments.length,
          itemBuilder: (context, index) {
            final payment = payments[index].data() as Map<String, dynamic>;
            final tenantName = payment['tenantName'] ?? 'N/A';
            final rentAmount = payment['rentAmount'] ?? 0.0;
            final timestamp = payment['timestamp'] != null
                ? (payment['timestamp'] as Timestamp).toDate()
                : DateTime.now();

            return ListTile(
              title: Text(
                'Tenant: $tenantName',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Rent Amount: \$${rentAmount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                'Date: ${DateFormat.yMd().format(timestamp)}',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }
}
