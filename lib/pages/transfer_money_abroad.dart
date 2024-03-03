import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egycoin_mobile_app/components/rounded_button.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:egycoin_mobile_app/pages/transfer_success_screen.dart';

class TransferMoneyAbroadScreen extends StatefulWidget {
  @override
  _TransferMoneyAbroadScreenState createState() => _TransferMoneyAbroadScreenState();
}

class _TransferMoneyAbroadScreenState extends State<TransferMoneyAbroadScreen> {
  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankRegionController = TextEditingController();

  Future<void> sendMoneyAbroad() async {
    String? currentUserUID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserUID != null) {
      String receiverPhone = receiverPhoneController.text.trim();
      double amount = double.tryParse(amountController.text.trim()) ?? 0.0;
      String bankName = bankNameController.text.trim();
      String bankRegion = bankRegionController.text.trim();

      if (receiverPhone.isEmpty || amount <= 0 || bankName.isEmpty || bankRegion.isEmpty) {
        // Handle invalid input
        return;
      }

      // Save the transfer details to Firestore
      await FirebaseFirestore.instance.collection('transferAbroad').add({
        'sender_id': currentUserUID,
        'receiver_phone': receiverPhone,
        'amount': amount,
        'bank_name': bankName,
        'bank_region': bankRegion,
        'timestamp': Timestamp.now(),
      });

      // Navigate to the success screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransferSuccessScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transfer Money Abroad",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedInputField(
                  hintText: "Receiver's Phone number",
                  icon: Icons.phone,
                  controller: receiverPhoneController,
                ),
                RoundedInputField(
                  hintText: "Amount",
                  icon: Icons.money,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                ),
                RoundedInputField(
                  hintText: "Bank Name",
                  icon: Icons.account_balance,
                  controller: bankNameController,
                ),
                RoundedInputField(
                  hintText: "Bank Region",
                  icon: Icons.location_city,
                  controller: bankRegionController,
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "Send Money",
                  onPressed: sendMoneyAbroad,
                ),
              ],
            ),
          ),
        ),
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
