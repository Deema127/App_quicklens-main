import 'package:flutter/material.dart';

class UsernameEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;

  const UsernameEmailFormField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.errorText,
    this.border,
    this.fillColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border ?? const OutlineInputBorder(),
        filled: filled,
        fillColor: fillColor,
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator ?? _defaultValidator,
      onChanged: onChanged,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter $label';
    }
    if (keyboardType == TextInputType.emailAddress && !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
