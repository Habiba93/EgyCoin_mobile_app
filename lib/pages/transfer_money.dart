import 'package:egycoin_mobile_app/components/rounded_button.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:egycoin_mobile_app/pages/transfer_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferMoneyScreen extends StatefulWidget {
  @override
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  final receiverPhonenoController = TextEditingController();
  final amountController = TextEditingController();
  double currentBalance = 0.0;

  @override
  void initState() {
    super.initState();
    _getCurrentUserBalance();
  }

  Future<void> _getCurrentUserBalance() async {
    final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to transfer money')),
      );
      return;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserUID).get();
    if (userDoc.exists) {
      // Retrieve balance as a string
      String balanceString = userDoc.data()?['balance'] ?? '0.0';
      // Convert string to double
      double balance = double.tryParse(balanceString) ?? 0.0;
      setState(() {
        currentBalance = balance;
      });
    }
  }

  Future<void> transferMoney() async {
    final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to transfer money')),
      );
      return;
    }

    String receiverPhoneno = receiverPhonenoController.text.trim();
    double amount = double.tryParse(amountController.text.trim()) ?? 0.0;

    if (receiverPhoneno.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number and amount')),
      );
      return;
    }

    if (currentBalance < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient balance')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('transferMoney').add({
      'sender_id': currentUserUID,
      'receiver_phone_number': receiverPhoneno,
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the current user's balance (assuming 'balance' is stored as a string)
    String newBalanceString = (currentBalance - amount).toString();
    await FirebaseFirestore.instance.collection('users').doc(currentUserUID).update({
      'balance': newBalanceString,
    });

    setState(() {
      currentBalance -= amount;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransferSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        title: Text('Transfer Money'),
      ),
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
                controller: receiverPhonenoController,
                keyboardType: TextInputType.phone,
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
              Text(
                'Current Balance: \$${currentBalance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.02,
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
    this.keyboardType = TextInputType.text,
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
