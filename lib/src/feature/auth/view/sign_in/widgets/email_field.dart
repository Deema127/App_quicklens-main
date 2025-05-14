
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class EmailField extends StatelessWidget {
  final AuthCrl crl;
  const EmailField({required this.crl, super.key});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      hintText: "Email Address",
      onChanged: (newVal) {
        crl.setEmail(newVal);
      },
      validator: (value) {
        if (value == null || !GetUtils.isEmail(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
