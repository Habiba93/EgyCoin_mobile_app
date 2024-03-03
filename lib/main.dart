import 'package:egycoin_mobile_app/pages/bills.dart';
import 'package:egycoin_mobile_app/pages/login_with_phoneno.dart';
import 'package:egycoin_mobile_app/pages/loan_screen.dart';
import 'package:egycoin_mobile_app/pages/pay_bill.dart';
import 'package:egycoin_mobile_app/pages/settings.dart';
import 'package:egycoin_mobile_app/pages/transfer_money.dart';
import 'package:egycoin_mobile_app/pages/loan_screen.dart';
import 'package:egycoin_mobile_app/pages/transfer_money_abroad.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:egycoin_mobile_app/pages/login_page.dart';
import 'package:egycoin_mobile_app/pages/signin_screen.dart';
import 'package:egycoin_mobile_app/pages/signup_page.dart';
import 'package:egycoin_mobile_app/pages/welcome_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomePage(),
    );
  }
}
