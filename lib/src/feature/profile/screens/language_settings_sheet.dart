import 'package:flutter/material.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'package:quicklens/src/core/widgets/app/themes/text_styles.dart';
import 'package:quicklens/src/feature/profile/widgets/custom_bottom_sheet.dart';

class LanguageSettingsSheet extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageSettingsSheet({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CustomBottomSheet(
      title: 'Language',
      children: [
        _buildOptionTile(
          title: l10n?.translate('followSystem') ?? "Follow the phone's system",
          isSelected: selectedLanguage == 'system',
          onTap: () => onLanguageSelected('system'),
        ),
        const SizedBox(height: 8),
        _buildOptionTile(
          title: l10n?.translate('languageName') ?? "English",
          isSelected: selectedLanguage == 'en',
          onTap: () => onLanguageSelected('en'),
        ),
        const SizedBox(height: 8),
        _buildOptionTile(
          title: "عربي",
          isSelected: selectedLanguage == 'ar',
          onTap: () => onLanguageSelected('ar'),
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.textTheme.bodyLarge),
            ),
            if (isSelected) const Icon(Icons.check, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
