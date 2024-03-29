import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback action;
  double width;
  double height;

  CustomButton({
    required this.buttonText,
    required this.action,
    this.width = double.infinity,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: ElevatedButton(
        onPressed: action,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(componentColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(width, height),
          ),
        ),
      ),
    );
  }
}
