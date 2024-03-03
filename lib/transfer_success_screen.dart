import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class TransferSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Success'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Transfer Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ); // Navigate back to the previous screen
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
