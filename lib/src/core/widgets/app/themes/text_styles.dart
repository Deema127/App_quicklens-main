import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.textDark),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textLight),
  );
}
