import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguageScreen(),
    );
  }
}

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Set the language to French
                // You can replace this with your own logic to change the app language
                // For simplicity, we'll just print the selected language
                print('Arabic selected');
                // Navigate to the next screen after selecting the language
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(language: 'Arabic')),
                );
              },
              child: Text('Arabic'),
            ),
            ElevatedButton(
              onPressed: () {
                // Set the language to English
                // You can replace this with your own logic to change the app language
                // For simplicity, we'll just print the selected language
                print('English selected');
                // Navigate to the next screen after selecting the language
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(language: 'English')),
                );
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                // Set the language to Spanish
                // You can replace this with your own logic to change the app language
                // For simplicity, we'll just print the selected language
                print('Spanish selected');
                // Navigate to the next screen after selecting the language
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(language: 'Spanish')),
                );
              },
              child: Text('Spanish'),
            ),
            ElevatedButton(
              onPressed: () {
                // Set the language to French
                // You can replace this with your own logic to change the app language
                // For simplicity, we'll just print the selected language
                print('French selected');
                // Navigate to the next screen after selecting the language
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(language: 'French')),
                );
              },
              child: Text('French'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String language;

  const HomeScreen({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!\nSelected Language: $language',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}