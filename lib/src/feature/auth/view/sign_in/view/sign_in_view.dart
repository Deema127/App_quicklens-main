import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/app_logo.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/email_field.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/forgot_password.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/login_button.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/password_field.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/widgets/sign_up_link.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCrl>(
      init: AuthCrl(),
      builder: (crl) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: Form(
            key: crl.loginFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppLogo(), // الشعار

                    SizedBox(height: 30.h),
                    EmailField(crl: crl), // حقل البريد الإلكتروني
                    SizedBox(height: 15.h),
                    PasswordField(crl: crl), // حقل كلمة المرور
                    SizedBox(height: 5.h),
                    const ForgotPassword(), // رابط "نسيت كلمة المرور"
                    SizedBox(height: 20.h),
                    LoginButton(crl: crl), // زر "تسجيل الدخول"
                    SizedBox(height: 20.h),
                    const SignUpLink(), // رابط "التسجيل"
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
