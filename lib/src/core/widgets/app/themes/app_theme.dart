import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextStyles.textTheme,
    iconTheme: const IconThemeData(color: Colors.black87),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryLight,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
  );
}
