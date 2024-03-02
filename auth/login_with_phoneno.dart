import 'package:egycoin_mobile_app/components/rounded_button.dart';
import 'package:egycoin_mobile_app/pages/auth/verify_code.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNo extends StatefulWidget {
  const LoginWithPhoneNo({super.key});

  @override
  State<LoginWithPhoneNo> createState() => _LoginWithPhoneNoState();
}

class _LoginWithPhoneNoState extends State<LoginWithPhoneNo> {
  bool loading=false;
  final phoneNumberController = TextEditingController();
  //final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
        
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+0201234567891'
              ),
            ),
            SizedBox(height: 80,),
            RoundedButton(text: 'Login',onPressed: (){
              // auth.verifyPhoneNumber(
              //   phoneNumber:phoneNumberController.text,
              //   verificationCompleted: (_){
                  
              //   } ,
              //   verificationFailed:(e){
              //     util().toastMessage(e.toString());
              //   },
              //   codeSent: (String verificationId, int? token ) {
              //     Navigator.push(context,
              //     MaterialPageRoute(
              //       builder: (context)=> VerifyCodeScreen(verificationId:verificationId ,)));
              //   },
              //   codeAutoRetrievalTimeout: (){
              //     util().toastMessage(e.toString());
              //   });
            },)
          ],
        ),
      ),
    );
  }
}