import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget clientDataText(
    {required String label,
    required double size,
    FontWeight weight = FontWeight.normal,
    TextOverflow overFlow = TextOverflow.ellipsis,
    myColor}) {
  return Text(
    '$label',
    style: TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: myColor,
    ),
    overflow: overFlow,
  );
}

Widget separateItem() => Container(
      height: 1,
      color: Colors.grey,
    );

Widget textFormField(String text, prefix, textFormFieldController, validate) =>
    TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelText: '$text',
        labelStyle: TextStyle(
          color: Color(0xff9a0007),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: textFormFieldController,
      validator: validate,
    );