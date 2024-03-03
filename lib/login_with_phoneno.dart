import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginWithPhoneNo extends StatefulWidget {
  const LoginWithPhoneNo({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNo> createState() => _LoginWithPhoneNoState();
}

class _LoginWithPhoneNoState extends State<LoginWithPhoneNo> {
  final TextEditingController phoneController = TextEditingController();

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of SMS code completed
        // Signing the user in (phone auth automatic sign-in)
        await _auth.signInWithCredential(credential);
        // Navigate to the next screen or perform any other action
        print("User automatically signed in: ${_auth.currentUser?.uid}");
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
        print("Phone number verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // OTP code sent to the provided phone number
        // You can save the verification ID and use it to manually authenticate the user later
        print("OTP sent: $verificationId");
        // Navigate to the OTP verification screen
        // For simplicity, we'll skip this in this example
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval of OTP timed out (after 30 seconds)
        print("OTP auto-retrieval timed out: $verificationId");
      },
    );
  }

  void _loginWithPhoneNumber() async {
    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.isNotEmpty) {
      // Remove any non-numeric characters from the phone number
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      await _verifyPhoneNumber("+20$phoneNumber"); // Modify country code as needed
    } else {
      // Handle empty phone number input
      print("Please enter a valid phone number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade50,
                  ),
                  child: Image.asset('lib/icons/person.png'),
                ),
                const SizedBox(height: 20),
                const Text('Login',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                const Text(
                  "Add your phone number! We'll send you a verification code",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryCodePicker(
                        onChanged: (CountryCode? countryCode) {
                          // Handle country code change
                        },
                        initialSelection: 'IN', // Initial country code
                        favorite: ['+20', 'IN'], // Your favorite country codes
                        showCountryOnly: false,
                        showFlagMain: false,
                        alignLeft: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loginWithPhoneNumber,
                  child: Text('Verify Phone Number'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
