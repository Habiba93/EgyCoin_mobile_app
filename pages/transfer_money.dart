import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/components/rounded_button.dart';
import 'package:egycoin_mobile_app/components/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransferMoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController receiver_phonenoController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    void transferMoney() async {
      // Get the current user's UID
      String? currentUserUID = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserUID != null) {
        // Get the receiver's phone number and amount from the text fields
        String receiver_phoneno = receiver_phonenoController.text.trim();
        double amount = double.tryParse(amountController.text.trim()) ?? 0.0;

        // Check if the receiver's phone number and amount are valid
        if (receiver_phoneno.isEmpty || amount <= 0) {
          // Handle invalid input
          return;
        }

        // Save the transfer details to Firestore
        await FirebaseFirestore.instance.collection('transferMoney').add({
          'sender_id': currentUserUID,
          'receiver_phone_number': receiver_phoneno,
          'amount': amount,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Optionally, you can navigate to a success screen or show a message to the user
      }
    }

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transfer Money",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RoundedInputField(
                key: Key("Receiver's Phone number"),
                hintText: "Receiver's Phone number",
                icon: Icons.phone,
                controller: receiver_phonenoController,
                keyboardType: TextInputType.text,
              ),
              RoundedInputField(
                key: Key("Amount"),
                hintText: "Amount",
                icon: Icons.money,
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RoundedButton(
                key: Key("Send Money"), 
                text: "Send Money",
                onPressed: transferMoney,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.controller,
    this.keyboardType = TextInputType.text, // Default keyboard type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
