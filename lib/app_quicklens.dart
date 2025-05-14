import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quicklens/src/core/config/bindings.dart';
import 'package:quicklens/src/feature/pages_start/init_start_view.dart';
import 'package:quicklens/src/feature/profile/profile_page.dart';
import 'package:quicklens/src/feature/profile/screens/account_settings_screen.dart';

class AppQuicklens extends StatelessWidget {
  const AppQuicklens({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: MyBindings(),
          home: child,
          getPages: [
            GetPage(name: '/', page: () => const InitStartView()),
            GetPage(name: '/profile', page: () => const ProfilePage()),
            GetPage(
              name: '/account-settings',
              page: () => const AccountSettingsSheet(),
            ),
          ],
        );
      },
      child: const InitStartView(),
    );
  }
}
