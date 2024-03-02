import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egycoin_mobile_app/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/pages/account_screen.dart';
import 'package:egycoin_mobile_app/pages/pay_bill.dart';
import 'package:egycoin_mobile_app/pages/transfer_money.dart';
import 'package:egycoin_mobile_app/pages/transfer_money_abroad.dart';
import 'package:egycoin_mobile_app/util/my_button.dart';
import 'package:egycoin_mobile_app/util/my_card.dart';
import 'package:egycoin_mobile_app/util/my_list_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
void main() {
  runApp(policy());
}

class policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy & Security',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrivacySecurityPage(),
    );
  }
}

class PrivacySecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Our privacy policy explains how we collect, use, and protect your personal information when you use our app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Security Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1. Secure Transactions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We use industry-standard security measures to ensure the safety and confidentiality of your transactions. This includes encryption, secure data storage, and multi-factor authentication.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. Protection Against Fraud:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We employ various fraud detection and prevention techniques to safeguard your account against unauthorized access and fraudulent activities.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. User Authentication:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'To protect your account, we require strong passwords and may implement additional authentication methods such as biometrics or one-time passcodes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. Regular Security Audits:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We conduct regular security audits and assessments to identify and address potential vulnerabilities in our systems and infrastructure.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}