import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quicklens/src/feature/business_details/controller/business_details_controller.dart';
import 'package:quicklens/src/feature/business_details/view/widgets/business_details_form.dart';

class BusinessDetailsScreen extends StatelessWidget {
  const BusinessDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessDetailsController>(
      init: BusinessDetailsController(),
      builder: (crl) {
        return Scaffold(
          backgroundColor: const Color(0xffEAEAEA),
          body: SafeArea(child: BusinessDetailsForm(crl: crl)),
        );
      },
    );
  }
}
