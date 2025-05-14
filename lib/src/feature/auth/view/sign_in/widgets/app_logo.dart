import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Column(
        children: [
          Text(
            "Quicklens",
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'serif',
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            "Login",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
