import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egycoin_mobile_app/pages/widgets/pin_code_widget.dart'; // Import PinCodePage
import 'package:egycoin_mobile_app/pages/settings.dart'; // Import SettingsPage

class PinCodeScreen extends StatelessWidget {
  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final pinCodeController = TextEditingController();
  // Function to save PIN in Firebase
  Future<void> _savePin(String pin, BuildContext context) async {
    final currentUserUID = _auth.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserUID)
          .set({'pinCode': pin},
              SetOptions(merge: true)); // Merge the new pin with existing data
      // Show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PIN saved successfully')),
      );
      // Navigate to the settings page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    } catch (error) {
      print('Failed to save PIN: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter PIN'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PinCodePage(
              // Pass the onSavePin function to PinCodePage
              onSavePin: (pin) => _savePin(pin, context),
            ),
          ),
          ElevatedButton(
            onPressed: () => _savePin(pinCodeController.text,
                context), // Save the entered PIN when pressed
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PinCodeScreen(), // Use PinCodeScreen as the home page
    );
  }
}
