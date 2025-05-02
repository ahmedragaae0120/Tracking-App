import 'package:flutter/material.dart';

class AddressCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const AddressCustomTextField(
      {super.key,
      required this.controller,
      this.keyboard,
      required this.labelText,
      this.hintText,
      this.validator,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelSmall,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            style: BorderStyle.none,
            width: 4,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
