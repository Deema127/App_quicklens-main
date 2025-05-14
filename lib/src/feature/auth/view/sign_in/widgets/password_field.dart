import 'package:flutter/material.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class PasswordField extends StatelessWidget {
  final AuthCrl crl;
  const PasswordField({required this.crl, super.key});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      obscureText: crl.isVisable,
      hintText: "Password",
      suffixIcon: crl.isVisable ? Icons.visibility_off
       : Icons.visibility,
      onTapSuffixIcon: () {
        crl.setIsVisable();
      },
      onChanged: (newVal) {
        crl.setPassword(newVal);
      },
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }
}
