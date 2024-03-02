import 'package:egycoin_mobile_app/pages/language_page.dart';
import 'package:egycoin_mobile_app/pages/login_page.dart';
import 'package:egycoin_mobile_app/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:egycoin_mobile_app/pages/policy.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? 'Guest',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
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
                   MaterialPageRoute(builder: (context) =>policy ()),
                 );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to the notification settings screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                // );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Navigate to the language settings screen
                 Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => LanguageScreen()),
                 );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Log out the user
                FirebaseAuth.instance.signOut();
                // Navigate to the login screen or home screen after logout
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
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