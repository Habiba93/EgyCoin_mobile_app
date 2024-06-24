import 'package:egycoin_mobile_app/pages/controllers/auth_controller.dart';
import 'package:egycoin_mobile_app/pages/verify_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  bool enableOtpBtn = false;
  String phoneNumber = '';
  getOtp() {
    PhoneAuthController.sendOtp(context, phoneNumber);
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //   return VerifyOtpPage(
    //     phoneNumber: phoneNumber,
    //     //verificationId: verificationId,
    //   );
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const Text("Please enter a valid phone number to verify"),
              const SizedBox(
                height: 30,
              ),
              InternationalPhoneNumberInput(
                onInputValidated: (value) {
                  print(value);
                  setState(() {
                    enableOtpBtn = value;
                  });
                },
                onInputChanged: (value) {
                  setState(() {
                    phoneNumber = value.phoneNumber!;
                  });
                },
                formatInput: true,
                autoFocus: true,
                keyboardType: TextInputType.phone,
                selectorConfig: const SelectorConfig(
                  useEmoji: true,
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                inputDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: enableOtpBtn ? getOtp : null,
                    child: const Text("Verify")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
