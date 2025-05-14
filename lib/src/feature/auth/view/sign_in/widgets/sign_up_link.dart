

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/view/sign_up_view.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            // Clear form data and navigate to sign-up page
            Get.off(() => const SignUpView());
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(20.w, 20.h),
          ),
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.pink[300],
            ),
          ),
        ),
      ],
    );
  }
}