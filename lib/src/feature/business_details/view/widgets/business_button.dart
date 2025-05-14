import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quicklens/src/core/widgets/custom_buttom_widget.dart';
import 'package:quicklens/src/feature/business_details/controller/business_details_controller.dart';

class BusinessButton extends StatelessWidget {
  const BusinessButton({super.key, required this.crl});
  final BusinessDetailsController crl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child:
          crl.isLoading
              ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.pink,
                  size: 20.sp,
                ),
              )
              : CustomButtomWidget(
                text: "Next",
                onPressed: () {
                  crl.saveBusinessDetails(context);
                },
              ),
    );
  }
}
