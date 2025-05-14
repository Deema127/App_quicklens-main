import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklens/src/feature/business_details/controller/business_details_controller.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_button.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_currency.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_header.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_industry.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_location.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_name.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_type.dart';

class BusinessDetailsForm extends StatelessWidget {
  const BusinessDetailsForm({super.key, required this.crl});
  final BusinessDetailsController crl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: crl.formKey,

      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 70.h),
        child: Column(
          children: [
            BusinessHeader(),
            SizedBox(height: 42.h),
            BusinessName(crl: crl),
            SizedBox(height: 30.h),
            BusinessIndustry(crl: crl),
            SizedBox(height: 30.h),
            BusinessType(crl: crl),
            SizedBox(height: 30.h),
            BusinessLocation(crl: crl),
            SizedBox(height: 30.h),
            BusinessCurrency(crl: crl),
            SizedBox(height: 50.h),
            BusinessButton(crl: crl),
          ],
        ),
      ),
    );
  }
}
