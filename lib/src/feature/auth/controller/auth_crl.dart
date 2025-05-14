import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicklens/src/core/config/app_strings.dart';
import 'package:quicklens/src/core/utils/my_aleart_dialog.dart';
import 'package:quicklens/src/feature/auth/model/user_model.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/view/sign_in_view.dart';
import 'package:quicklens/src/feature/business_details/view/business_details_screen.dart';
import 'package:quicklens/src/feature/home/home_view.dart';

class AuthCrl extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> signupFormKey;

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    signupFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    loginFormKey.currentState?.dispose();
    signupFormKey.currentState?.dispose();
    super.onClose();
  }

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  ///----User Model
  UserModel userModel = UserModel(
    id: '',
    email: '',
    password: '',
    cpassword: '',
    firstname: '',
    lastname: '',
    username: '',
  );

  void setEmail(String newVal) {
    userModel.email = newVal;
    update();
  }

  void firstName(String newVal) {
    userModel.firstname = newVal;
    update();
  }

  void lastName(String newVal) {
    userModel.lastname = newVal;
    update();
  }

  void username(String newVal) {
    userModel.username = newVal;
    update();
  }

  void setPassword(String newVal) {
    userModel.password = newVal;
    update();
  }

  void setCPassword(String newVal) {
    userModel.cpassword = newVal;
    update();
  }

  bool isLoading = false;
  void setIsLoading(bool newVal) {
    isLoading = newVal;
    update();
  }

  bool isVisable = true;
  void setIsVisable() {
    isVisable = !isVisable;
    update();
  }

  void clearData() {
    userModel = UserModel(
      id: '',
      email: '',
      password: '',
      cpassword: '',
      firstname: '',
      lastname: '',
      username: '',
    );

    update();
  }

  Future<void> signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    signupFormKey.currentState!.save();

    final bool isValid = signupFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        await myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.firstname.isEmpty) {
        await myAleartDialog(context, text: 'Please enter your first name');
      } else if (userModel.lastname.isEmpty) {
        await myAleartDialog(context, text: 'Please enter your last name');
      } else if (userModel.password.length <= 8 &&
          userModel.cpassword.length <= 8) {
        await myAleartDialog(
          context,
          text: 'Password must be 8 characters at least',
        );
      } else if (userModel.password != userModel.cpassword) {
        await myAleartDialog(context, text: 'Passwords do not match');
      } else if (isValid) {
        setIsLoading(true);
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) async {
              userModel.id = userCedential.user!.uid;

              // Add data to Firestore
              DocumentReference ref = FirebaseFirestore.instance
                  .collection(AppStrings.users)
                  .doc(userCedential.user!.uid);

              try {
                // Send email verification
                await userCedential.user!.sendEmailVerification();

                // Add emailVerified status to user data
                Map<String, dynamic> userData = userModel.toMap();
                userData['emailVerified'] = false;

                await ref.set(userData);
                log('User data added to Firestore');

                if (context.mounted) {
                  await myAleartDialog(
                    context,
                    text: 'Verification email sent. Please check your inbox.',
                  );
                  Route route = MaterialPageRoute(
                    builder: (_) => const BusinessDetailsScreen(),
                  );
                  Navigator.pushReplacement(context, route);
                }
              } catch (error) {
                log('Error adding user data: $error');
              } finally {
                setIsLoading(false);
              }
            });
      }
    } on FirebaseAuthException catch (e) {
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The email address is badly formatted.',
        );
      } else {
        log(e.toString());
      }
    }
  }

  Future<void> logIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    loginFormKey.currentState!.save();

    final bool isValid = loginFormKey.currentState!.validate();

    try {
      if (!userModel.email.isEmail) {
        await myAleartDialog(context, text: 'Please enter a valid email');
      } else if (userModel.password.length <= 6) {
        await myAleartDialog(
          context,
          text: 'Passwords must be 6 characters at least',
        );
      } else if (isValid) {
        setIsLoading(true);

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: userModel.email,
              password: userModel.password,
            )
            .then((UserCredential userCedential) async {
              if (!userCedential.user!.emailVerified) {
                if (context.mounted) {
                  await myAleartDialog(
                    context,
                    text:
                        'Please verify your email first. Check your inbox for the verification link.',
                  );
                  await userCedential.user!.sendEmailVerification();
                }
                setIsLoading(false);
                return;
              }

              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/profile');
              }
              setIsLoading(false);
            });
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        await myAleartDialog(context, text: e.toString());
      }
      setIsLoading(false);
      log(e.toString());

      if (e.code == 'weak-password' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email' && context.mounted) {
        await myAleartDialog(
          context,
          text: 'The email address is badly formatted.',
        );
      } else {
        log(e.toString());
      }
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      setIsLoading(true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        await myAleartDialog(
          context,
          text: 'Password reset email sent to $email',
        ).then((_) {
          if (context.mounted) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).popUntil((route) => route.isFirst);
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      await myAleartDialog(
        context,
        text: 'Error sending reset email: ${e.message}',
      );
      log('Password reset error: ${e.message}');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      clearData(); // Clear user data
      Get.offAll(
        () => const SignInView(),
        predicate: (route) => false, // Clear all routes
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> updateEmail(String newEmail, BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        await FirebaseFirestore.instance
            .collection(AppStrings.users)
            .doc(user.uid)
            .update({'email': newEmail});
        if (context.mounted) {
          await myAleartDialog(context, text: 'Email updated successfully');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        await myAleartDialog(
          context,
          text: 'Error updating email: ${e.message}',
        );
      }
    }
  }

  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
    BuildContext context,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (context.mounted) {
          await myAleartDialog(context, text: 'User not found');
        }
        return;
      }

      // First verify current password matches
      try {
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(cred);
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          await myAleartDialog(context, text: 'Current password is incorrect');
        }
        return;
      }

      // Update password if verification succeeded
      await user.updatePassword(newPassword);

      if (context.mounted) {
        await myAleartDialog(context, text: 'Password updated successfully');
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        await myAleartDialog(
          context,
          text: 'Error updating password: ${e.message}',
        );
      }
    } catch (e) {
      if (context.mounted) {
        await myAleartDialog(context, text: 'An unexpected error occurred');
      }
    }
  }

  Future<void> updateUsername(String username, BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(AppStrings.users)
            .doc(user.uid)
            .update({'username': username});
        if (context.mounted) {
          await myAleartDialog(context, text: 'Username updated successfully');
        }
      }
    } catch (e) {
      if (context.mounted) {
        await myAleartDialog(context, text: 'Error updating username: $e');
      }
    }
  }
}
