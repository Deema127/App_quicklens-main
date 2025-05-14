import 'package:flutter/material.dart';
import 'package:quicklens/src/core/utils/logger.dart';
import 'package:get/get.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:quicklens/src/feature/profile/widgets/custom_bottom_sheet.dart';
import 'package:quicklens/src/feature/profile/widgets/password_form_field.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet>
    with SingleTickerProviderStateMixin {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late AnimationController _animationController;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveNewPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final currentPass = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (currentPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter current password')),
      );
      return;
    }

    if (newPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter new password')),
      );
      return;
    }

    if (newPass == currentPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password must be different')),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);
    AppLogger.i('Starting password change process');
    try {
      final authCrl = Get.find<AuthCrl>();
      AppLogger.d(
        'Current password: ${currentPasswordController.text.isNotEmpty ? 'provided' : 'empty'}',
      );
      AppLogger.d('New password: ${newPasswordController.text}');

      await authCrl.updatePassword(
        currentPasswordController.text,
        newPasswordController.text,
        context,
      );

      AppLogger.i('Password updated successfully in Firebase Auth');
      if (!mounted) return;

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
    } catch (e, stackTrace) {
      AppLogger.e('Password change failed', e, stackTrace);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error changing password: ${e.toString()}')),
      );
    } finally {
      AppLogger.v('Password change process completed');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, isRTL ? -0.5 : 0.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeOut,
              ),
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: CustomBottomSheet(
                title: l10n?.translate('changePassword') ?? 'Change Password',
                onBack: () => Navigator.of(context).pop(),
                children: [
                  PasswordFormField(
                    controller: currentPasswordController,
                    label:
                        l10n?.translate('currentPassword') ??
                        'Current Password',
                    hintText:
                        l10n?.translate('enterCurrentPassword') ??
                        'Enter current password',
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: newPasswordController,
                    confirmPasswordController: confirmPasswordController,
                    label: l10n?.translate('newPassword') ?? 'New Password',
                    hintText:
                        l10n?.translate('enterNewPassword') ??
                        'Enter new password',
                    showStrengthIndicator: true,
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: confirmPasswordController,
                    confirmPasswordController: newPasswordController,
                    label:
                        l10n?.translate('confirmPassword') ??
                        'Confirm Password',
                    hintText:
                        l10n?.translate('confirmNewPassword') ??
                        'Confirm new password',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveNewPassword,
                    child:
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                              l10n?.translate('saveChanges') ?? 'Save Changes',
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
