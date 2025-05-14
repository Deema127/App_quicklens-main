import 'package:flutter/material.dart';
import 'package:quicklens/l10n/app_localizations.dart';

class PasswordValidator {
  static String? validate(
    String? value, {
    required BuildContext context,
    bool isCurrent = false,
    bool isNew = false,
    bool isConfirm = false,
    int minLength = 6,
    String? confirmValue,
  }) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      // Fallback to English if translations not loaded
      if (value == null || value.isEmpty) {
        if (isCurrent) return 'Please enter current password';
        if (isNew) return 'Please enter new password';
        if (isConfirm) return 'Please confirm password';
        return 'Please enter password';
      }
      if (value.length < minLength) {
        return 'Password must be at least $minLength characters';
      }
      if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain at least one lowercase letter';
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain at least one number';
      }
      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Password must contain at least one special character';
      }
      if (isConfirm && value != confirmValue) {
        return 'Passwords do not match';
      }
      return null;
    }

    // Use translations when available
    if (value == null || value.isEmpty) {
      if (isCurrent) return l10n.translate('currentPasswordEmpty');
      if (isNew) return l10n.translate('newPasswordEmpty');
      if (isConfirm) return l10n.translate('confirmPasswordEmpty');
      return l10n.translate('passwordEmpty');
    }
    if (value.length < minLength) return l10n.translate('passwordMinLength');
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return l10n.translate('passwordNoUppercase');
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return l10n.translate('passwordNoLowercase');
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return l10n.translate('passwordNoNumber');
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return l10n.translate('passwordNoSpecialChar');
    }
    if (isConfirm && value != confirmValue) {
      return l10n.translate('passwordsDontMatch');
    }

    return null;
  }
}
