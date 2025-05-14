import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quicklens/src/core/config/app_strings.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/view/sign_in_view.dart';
import 'package:quicklens/src/feature/home/home_view.dart';

import '../auth/model/user_model.dart';

class InitStartView extends StatelessWidget {
  const InitStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        return GetBuilder<AuthCrl>(
          init: AuthCrl(),
          builder: (authCrl) {
            switch (snapShot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: Colors.red,
                    size: 18,
                  ),
                );
              case ConnectionState.active:
                if (snapShot.hasData) {
                  return StreamBuilder<DocumentSnapshot>(
                    stream:
                        FirebaseFirestore.instance
                            .collection(AppStrings.users)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (userSnapshot.hasData && userSnapshot.data != null) {
                        // تأكد من تعيين userModel بعد تحميل البيانات
                        authCrl.userModel = UserModel.fromMap(
                          userSnapshot.data!.data() as Map<String, dynamic>,
                        );
                        return HomeView();
                      } else {
                        return const SignInView();
                      }
                    },
                  );
                } else {
                  return const SignInView();
                }
              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }
}
