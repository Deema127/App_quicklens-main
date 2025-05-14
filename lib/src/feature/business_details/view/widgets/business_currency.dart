import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/core/widgets/my_text_field.dart';
import 'package:quicklens/src/feature/business_details/controller/business_details_controller.dart';

class BusinessCurrency extends StatelessWidget {
  const BusinessCurrency({super.key, required this.crl});
  final BusinessDetailsController crl;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      height: 50.h,
      hintText: "Currency",
      onChanged: (value) => crl.setCurrency(value),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Currency';
        }
        return null;
      },
    );
  }
}
