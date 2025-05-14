
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quicklens/src/core/widgets/custom_buttom_widget.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class LoginButton extends StatelessWidget {
  final AuthCrl crl;
  const LoginButton({required this.crl, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: crl.isLoading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Colors.pink[300]!,
                size: 20.sp,
              ),
            )
          : CustomButtomWidget(
              text: "Log in",
              onPressed: () {
                crl.logIn(context);
              },
            ),
    );
  }
}