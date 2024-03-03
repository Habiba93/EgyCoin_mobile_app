import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late Stream<List<TransferRecord>> _transferStream;

  @override
  void initState() {
    super.initState();
    _transferStream = FirebaseFirestore.instance
        .collection('transfer')
        .where('sender_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => TransferRecord.fromMap(doc.data(), doc.id))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: StreamBuilder<List<TransferRecord>>(
        stream: _transferStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred while loading transfers.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('No transfers found.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final transfer = snapshot.data![index];
              return ListTile(
                title: Text('Receiver Phone: ${transfer.receiverPhone}'),
                subtitle: Text('Amount: ${transfer.amount}\n'
                    'Bank Name: ${transfer.bankName}\n'
                    'Bank Region: ${transfer.bankRegion}\n'
                    'Timestamp: ${transfer.timestamp.toDate()}'),
              );
            },
          );
        },
      ),
    );
  }
}

class TransferRecord {
  final String id;
  final String senderId;
  final String receiverPhone;
  final double amount;
  final String bankName;
  final String bankRegion;
  final Timestamp timestamp;

  TransferRecord({
    required this.id,
    required this.senderId,
    required this.receiverPhone,
    required this.amount,
    required this.bankName,
    required this.bankRegion,
    required this.timestamp,
  });

  factory TransferRecord.fromMap(Map<String, dynamic> data, String id) {
    return TransferRecord(
      id: id,
      senderId: data['sender_id'],
      receiverPhone: data['receiver_phone'],
      amount: data['amount'].toDouble(),
      bankName: data['bank_name'],
      bankRegion: data['bank_region'],
      timestamp: data['timestamp'] as Timestamp, // Convert Firestore Timestamp to Dart Timestamp
    );
  }
}
