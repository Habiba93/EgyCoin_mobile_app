import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egycoin_mobile_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBDC Sign-Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpPage(),
    );
  }
}

Future<void> addUserDetails(
    String firstname,
    String lastname,
    String userEmail,
    String nationalID,
    String userPhoneNumber,
    String id) async {
  await FirebaseFirestore.instance.collection('users').doc(id).set(
    {
      'firstname': firstname,
      'lastname': lastname,
      'email': userEmail,
      'mobile': userPhoneNumber,
      'nationalID': nationalID,
      'id': id,
    },
    SetOptions(merge: true), // This line ensures existing data is not deleted
  );

  print('NEW USER REGISTERED WITH ID:');
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CBDC Sign-Up Page'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Wallpaper section
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/icons/backg.JPG'), // Replace with your wallpaper image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Enter your personal information to get started.',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter your first name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter your last name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: nationalIdController,
                      decoration: InputDecoration(
                        labelText: 'National ID',
                        hintText: 'Enter your national ID',
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your national ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        // You can add additional validation for phone number format here if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // You can add additional validation for password strength here if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            addUserDetails(
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              nationalIdController.text,
                              phoneNumberController.text,
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
