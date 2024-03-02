import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/components/text_field_container.dart';
import 'package:egycoin_mobile_app/util/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: Constants.kPrimaryColor,
            ),
            border: InputBorder.none),
        onChanged: onChanged,
      ),
    );
  }
}