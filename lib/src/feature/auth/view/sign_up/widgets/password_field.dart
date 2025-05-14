import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class PasswordField extends StatelessWidget {
  final AuthCrl crl;
  const PasswordField({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      height: 50.h,
      obscureText: crl.isVisable,
      hintText: "Password",
      onChanged: (newVal) {
        crl.setPassword(newVal);
      },
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      onTapSuffixIcon: () {
        crl.setIsVisable();
      },
      suffixIcon: crl.isVisable ? Icons.visibility_off : Icons.visibility,
    );
  }
}
