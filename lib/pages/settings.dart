import 'package:egycoin_mobile_app/pages/pin_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:egycoin_mobile_app/pages/language_page.dart';
import 'package:egycoin_mobile_app/pages/welcome_screen.dart';
import 'package:egycoin_mobile_app/pages/policy.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Fetch user data from Firestore
    Future<DocumentSnapshot> getUserData() async {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      return userDoc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade50,
                  ),
                  child: Image.asset('lib/icons/account-manager.png'),
                ),
            SizedBox(height: 20),
            FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching user data');
                } else {
                  Map<String, dynamic>? userData =
                      snapshot.data?.data() as Map<String, dynamic>?;
                  String firstName = userData?['firstname'] ?? '';
                  String lastName = userData?['lastname'] ?? '';
                  return Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to the profile editing screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy & Security'),
              onTap: () {
                // Navigate to the privacy settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => policy()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Pin code'),
              onTap: () {
                // Navigate to the privacy settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinCodeScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to the notification settings screen
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.language),
            //   title: Text('Language'),
            //   onTap: () {
            //     // Navigate to the language settings screen
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LanguageScreen()),
            //     );
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Log out the user
                FirebaseAuth.instance.signOut();
                // Navigate to the login screen or home screen after logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button onPressed event
        },
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }
}
