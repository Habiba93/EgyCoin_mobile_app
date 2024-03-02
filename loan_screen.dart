//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:egycoin_mobile_app/components/error_dialog.dart';
import 'package:egycoin_mobile_app/components/my_buttons.dart';
import 'package:egycoin_mobile_app/components/reusable_check_pwd_modal.dart';
//import 'package:egycoin_app/DetailScreenPages/DetailsLoanScreenParts/get_loan_modal.dart';
//import 'package:egycoin_app/DetailScreenPages/DetailsLoanScreenParts/repay_loan.dart';
//import 'package:egycoin_app/my_functions.dart';
import 'package:egycoin_mobile_app/constants.dart';

class LoanScreen extends StatelessWidget {
  static String loanScreenRoute = 'loanScreenRoute';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Loan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Loan Service',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
          CustomButton(
            buttonText: 'Get Loan \$500',
            action: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) => GetLoanModal(controller),
              // );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          CustomButton(
            buttonText: 'Repay Loan',
            action: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) => RepayLoanModal(controller),
              // );
            },
          ),
        ],
      ),
    );
  }
}
