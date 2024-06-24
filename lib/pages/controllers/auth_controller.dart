import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:egycoin_mobile_app/pages/verify_otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PhoneAuthController {
  static final _auth = FirebaseAuth.instance;
  static Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    try {
      context.loaderOverlay.show();
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential) {},
        verificationFailed: (error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(error.message ??
                    "Something went wrong when verifying phone number"),
              ),
            );

          // if (error.code == 'invalid-phone-number') {
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(
          //         const SnackBar(content: Text("Invalid Phone Number")));
          // } else if (error.code == 'too-many-requests') {
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(
          //         const SnackBar(content: Text('Too Many Requests')));
          // } else {
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(const SnackBar(
          //         content: Text(
          //             'Something went wrong when verifying phone number')));
          // }
        },
        codeSent: (verificationId, forceResendingToken) {
          context.loaderOverlay.hide();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VerifyOtpPage(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text('Something went wrong when verifying phone number')));
    } catch (e) {
      print(e);
    } finally {
      context.loaderOverlay.hide();
    }
  }

  static Future<void> verifyOtp(
      BuildContext context, String verificationId, String smsCode) async {
    try {
      context.loaderOverlay.show();
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      if (!context.mounted) return;
      context.loaderOverlay.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
      // PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //   verificationId: verificationId,
      //   smsCode: smsCode
      // );
      // await _auth.signInWithCredential(credential);
      // ScaffoldMessenger.of(context)
      // ..hideCurrentSnackBar()
      // ..showSnackBar(SnackBar(content: Text("Logged in successfully")));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Something went wrong when verifying phone number'),
          ),
        );
    } catch (e) {
      print(e);
    }
    finally{
        context.loaderOverlay.hide();
    }
  }
}
