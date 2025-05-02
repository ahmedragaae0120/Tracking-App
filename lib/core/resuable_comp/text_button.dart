// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  Color color;
  Color textColor;
  String text;
  final Color borderColor;
  void Function()? onPressed;

  CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.borderColor,
      required this.text,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: borderColor, width: 2))),
          onPressed: onPressed,
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16))),
    );
  }
}
