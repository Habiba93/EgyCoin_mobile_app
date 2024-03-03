import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    required this.iconImagePath,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed, // Call the onPressed function when tapped
          child: Container(
            height: 90,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Image.asset(iconImagePath),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
