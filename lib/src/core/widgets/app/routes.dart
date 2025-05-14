import 'package:flutter/material.dart';
import 'package:quicklens/splash.dart';
import 'package:quicklens/src/feature/profile/profile_page.dart';
import 'package:quicklens/src/feature/profile/screens/account_settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/profile': (context) => const ProfilePage(),
  '/account-settings': (context) => const AccountSettingsSheet(),
};
