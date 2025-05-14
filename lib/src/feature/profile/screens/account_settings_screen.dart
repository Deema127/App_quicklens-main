import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/profile/screens/change_password_sheet.dart';
import 'package:quicklens/src/feature/profile/widgets/custom_bottom_sheet.dart';
import 'package:quicklens/src/feature/profile/widgets/password_form_field.dart';
import 'package:quicklens/src/feature/profile/widgets/username_email_form_field.dart';

class AccountSettingsSheet extends StatefulWidget {
  const AccountSettingsSheet({super.key});

  @override
  State<AccountSettingsSheet> createState() => _AccountSettingsSheetState();
}

class _AccountSettingsSheetState extends State<AccountSettingsSheet> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      setState(() {
        usernameController.text = doc.data()?['username'] ?? '';
        emailController.text = user.email ?? '';
        isLoading = false;
      });
    }
  }

  final passwordController = TextEditingController();

  Future<void> saveChanges() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // First update username in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
              'username': usernameController.text.trim(),
              'updatedAt': FieldValue.serverTimestamp(),
            });

        // Only attempt email update if changed
        if (emailController.text != user.email) {
          try {
            // Set Firebase language code to prevent locale warnings
            await FirebaseAuth.instance.setLanguageCode('en');

            await user.updateEmail(emailController.text);
            // Send verification email for the new address
            await user.sendEmailVerification();

            // Update email in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({
                  'email': emailController.text.trim(),
                  'emailVerified': false,
                });

            Get.snackbar(
              'Email Updated',
              'Verification email sent to your new address',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 4),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'operation-not-allowed') {
              Get.snackbar(
                'Action Required',
                'Please enable Email/Password provider in Firebase Console '
                    'under Authentication > Sign-in Methods',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 4),
              );
            } else {
              Get.snackbar(
                'Error',
                e.message ?? 'Failed to update email',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 4),
              );
            }
          }
        }

        // Update local state
        final authCrl = Get.find<AuthCrl>();
        authCrl.username(usernameController.text.trim());
        if (emailController.text == user.email) {
          authCrl.setEmail(emailController.text.trim());
        }

        // Refresh profile page data
        if (mounted) {
          Navigator.pop(context);
          Get.snackbar(
            'Success',
            'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return CustomBottomSheet(
      title: l10n?.translate('accountSettings') ?? 'Account Settings',
      onBack: () => Navigator.of(context).pop(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Username Field
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeOut,
                  ),
                ),
                child: FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: UsernameEmailFormField(
                    controller: usernameController,
                    label: l10n?.translate('username') ?? 'Username',
                    hintText:
                        l10n?.translate('enterUsername') ?? 'Enter username',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeOut,
                  ),
                ),
                child: FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: UsernameEmailFormField(
                    controller: emailController,
                    label: l10n?.translate('email') ?? 'Email',
                    hintText: l10n?.translate('enterEmail') ?? 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeOut,
                  ),
                ),
                child: FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ChangePasswordSheet(),
                        isScrollControlled: true,
                      );
                    },
                    child: AbsorbPointer(
                      child: PasswordFormField(
                        controller: passwordController,
                        label: l10n?.translate('password') ?? 'Password',
                        hintText:
                            l10n?.translate('changePassword') ??
                            'Tap to change password',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeOut,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: saveChanges,
                  child: Text(l10n?.translate('save') ?? 'Save'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
