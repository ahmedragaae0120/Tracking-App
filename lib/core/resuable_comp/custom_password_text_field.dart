// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../utils/string_manager.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    required this.label,
    this.placeholder, // ❌ إزالة `tr()` هنا لأنه يحتاج `BuildContext`
    this.controller,
    this.validator,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true; // Controls password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        obscuringCharacter: "★",
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: getInputDecoration(context, widget.label,
            widget.placeholder ?? AppStrings.enterYourPassword // ✅ الحل هنا
            ),
      ),
    );
  }

  InputDecoration getInputDecoration(
      BuildContext context, String label, String hint) {
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: inputTheme.labelStyle,
      hintStyle: inputTheme.hintStyle,
      floatingLabelBehavior: inputTheme.floatingLabelBehavior,
      border: inputTheme.border,
      enabledBorder: inputTheme.enabledBorder,
      focusedBorder: inputTheme.focusedBorder,
      contentPadding: inputTheme.contentPadding,
      fillColor: inputTheme.fillColor,
      filled: inputTheme.filled,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: _togglePasswordVisibility,
      ),
    );
  }
}
