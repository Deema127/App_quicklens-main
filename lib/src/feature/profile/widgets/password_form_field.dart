import 'package:flutter/material.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'package:quicklens/src/core/utils/password_validator.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? confirmPasswordController;
  final String? label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final String? hintText;
  final String? errorText;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final int minLength;
  final bool showStrengthIndicator;

  const PasswordFormField({
    super.key,
    required this.controller,
    this.confirmPasswordController,
    this.label,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.hintText,
    this.errorText,
    this.border,
    this.fillColor,
    this.filled = false,
    this.minLength = 8,
    this.showStrengthIndicator = false,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText:
                widget.label ?? l10n?.translate('password') ?? 'Password',
            hintText:
                widget.hintText ??
                l10n?.translate('enterPassword') ??
                'Enter password',
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: widget.border ?? const OutlineInputBorder(),
            filled: widget.filled,
            fillColor: widget.fillColor,
          ),
          validator: widget.validator ?? _defaultValidator,
          onChanged: widget.onChanged,
        ),
        if (widget.showStrengthIndicator && widget.controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(
              value: _calculatePasswordStrength(widget.controller.text),
              backgroundColor: Colors.grey[200],
              color: _getStrengthColor(widget.controller.text),
            ),
          ),
      ],
    );
  }

  String? _defaultValidator(String? value) {
    return PasswordValidator.validate(
      value,
      context: context,
      isCurrent: widget.label?.contains('Current') ?? false,
      isNew: widget.label?.contains('New') ?? false,
      isConfirm: widget.label?.contains('Confirm') ?? false,
      minLength: widget.minLength,
      confirmValue: widget.confirmPasswordController?.text,
    );
  }

  double _calculatePasswordStrength(String password) {
    // Simple strength calculation
    double strength = 0;
    if (password.length >= widget.minLength) strength += 0.3;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.3;
    return strength.clamp(0.0, 1.0);
  }

  Color _getStrengthColor(String password) {
    final strength = _calculatePasswordStrength(password);
    if (strength < 0.4) return Colors.red;
    if (strength < 0.7) return Colors.orange;
    return Colors.green;
  }
}
