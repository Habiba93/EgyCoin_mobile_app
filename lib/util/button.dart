import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const Button({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            child: Icon(
              Icons.phone_android,
              size: 36,
              color: Colors.grey[700],
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
