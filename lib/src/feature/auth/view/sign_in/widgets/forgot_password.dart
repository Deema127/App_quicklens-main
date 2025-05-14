
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Forgot password?",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[800],
            ),
          ),
          TextButton(
            onPressed: () {
              // Add forgot password functionality
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(40.w, 20.h),
            ),
            child: Text(
              "Reset",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.pink[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}