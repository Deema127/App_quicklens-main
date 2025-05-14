import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/auth/view/sign_up/widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCrl>(
      init: AuthCrl(),
      builder: (crl) {
        return Scaffold(

          backgroundColor: const Color(0xffEAEAEA),
          body: SafeArea(child: SignUpForm(crl: crl,)),
        );
      },
    );
  }
}
