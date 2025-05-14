import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final double? width;
  final double? height;
  final IconData? suffixIcon;
  final int maxLines;
  final void Function()? onTapSuffixIcon;
  final Function(String)? onChanged;
  final bool obscureText;
  final FocusNode? focusNode;

  const MyTextField({
    super.key,
    required this.hintText,
    this.width,
    this.height,
    required this.onChanged,
    this.suffixIcon,
    required this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.onTapSuffixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 10.h,
          ),
          suffixIcon:
              suffixIcon != null
                  ? InkWell(
                    onTap: onTapSuffixIcon,
                    child: Icon(suffixIcon, color: Colors.black87, size: 20.sp),
                  )
                  : null,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.normal,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorStyle: TextStyle(
            fontSize: 10.sp,
            height: 1,
            color: Colors.red.shade400,
          ),
        ),
      ),
    );
  }
}
