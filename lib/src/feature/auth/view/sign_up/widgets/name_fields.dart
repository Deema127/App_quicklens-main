import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class NameFields extends StatelessWidget {
  final AuthCrl crl;
  const NameFields({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            height: 50.h,
            hintText: "First name",
            onChanged: (newVal) {
              crl.firstName(newVal);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
          ),
        ),
        SizedBox(width: 10.w),
        // Last name field
        Expanded(
          child: MyTextField(
            height: 50.h,
            hintText: "Last name",
            onChanged: (newVal) {
              crl.lastName(newVal);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
