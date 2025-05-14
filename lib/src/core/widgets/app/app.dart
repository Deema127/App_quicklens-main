import 'package:flutter/material.dart';
import 'package:quicklens/l10n/app_localizations.dart';
import 'routes.dart';
import 'themes/app_theme.dart';

class QuicklensApp extends StatelessWidget {
  const QuicklensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quicklens',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: appRoutes,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        // First check if the device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        // If not, return the first supported locale (English)
        return supportedLocales.first;
      },
    );
  }
}
