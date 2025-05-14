import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtomWidget extends StatelessWidget {
  const CustomButtomWidget({super.key, this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: MaterialButton(
        
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Color(0xFFF5C0D0),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
