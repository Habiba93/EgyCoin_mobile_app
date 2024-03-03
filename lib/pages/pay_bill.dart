import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/util/my_button.dart';

class PayBillPage extends StatelessWidget {
  const PayBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Bill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for bill payment form or options
            Text(
              'Enter bill amount',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Placeholder for payment amount input field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // Placeholder for pay button
            MyButton(
              iconImagePath: 'lib/icons/credit-card.png',
              buttonText: 'Pay',
              onPressed: () {
                // Add logic to handle bill payment
              },
            ),
          ],
        ),
      ),
    );
  }
}
