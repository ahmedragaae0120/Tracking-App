import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String labelText;
  final Widget? icon;
  final String? hintText;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.labelText,
    this.hintText,
    this.icon,
    required this.controller,
    this.keyboard,
    this.validator,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelSmall,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        suffixIcon: suffixIcon,
        icon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            width: 4,
            color: Color(0xff535353),
          ),
        ),
      ),
    );
  }
}
