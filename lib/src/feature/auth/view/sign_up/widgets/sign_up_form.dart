import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/email_field.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/password_field.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/widgets/confirm_password_field.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/widgets/name_fields.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/widgets/sign_up_button.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/widgets/sign_up_header.dart';

class SignUpForm extends StatelessWidget {
  final AuthCrl crl;

  const SignUpForm({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: crl.signupFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(
          children: [
            SignUpHeader(),
            SizedBox(height: 42.h),
            NameFields(crl: crl),
            SizedBox(height: 30.h),
            EmailField(crl: crl),
            SizedBox(height: 30.h),
            PasswordField(crl: crl),
            SizedBox(height: 30.h),
            ConfirmPasswordField(crl: crl),
            SizedBox(height: 50.h),
            SignUpButton(crl: crl),
          ],
        ),
      ),
    );
  }
}
