import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/business_details/controller/business_details_controller.dart';

class BusinessType extends StatelessWidget {
  const BusinessType({super.key, required this.crl});
     final BusinessDetailsController crl;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      height: 50.h,
      hintText: "BusinessType",
             onChanged: (value) => crl.setType(value),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter BusinessType';
        }
        return null;
      },
    );
  }
}
