import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class EmailField extends StatelessWidget {
  final AuthCrl crl;
  const EmailField({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      height: 50.h,
      hintText: "Email Address",
      onChanged: (newVal) {
        crl.setEmail(newVal);
      },
      validator: (value) {
        if (value == null || !value.isEmail) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
