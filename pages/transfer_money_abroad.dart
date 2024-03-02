import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/components/rounded_button.dart';
import 'package:egycoin_mobile_app/components/rounded_input_field.dart';
import 'package:egycoin_mobile_app/pages/signup_page.dart';

class TransferMoneyAbroadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
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
                  hintText: "Receiver's Phone number",
                  icon: Icons.phone,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Amount",
                  icon: Icons.money,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Bank Name", // Add bank name input field
                  icon: Icons.account_balance,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Bank Region", // Add bank region input field
                  icon: Icons.location_city,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RoundedButton(
                  text: "Send Money",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
