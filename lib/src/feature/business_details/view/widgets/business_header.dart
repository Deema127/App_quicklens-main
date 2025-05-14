import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quicklens/src/feature/auth/view/sign_in/view/sign_in_view.dart';

class BusinessHeader extends StatelessWidget {
  const BusinessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30.sp,
            color: Color(0xff686767),
          ),
          onPressed: () {
            Get.off(SignInView());
          },
        ),
        SizedBox(width: 5.w),
        Text(
          "Business Details",
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
