import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quicklens/src/feature/business_details/model/business_model.dart';
import 'package:quicklens/src/feature/home/home_view.dart';

class BusinessDetailsController extends GetxController {
  BusinessModel businessModel = BusinessModel(
    name: '',
    industry: '',
    type: '',
    location: '',
    currency: '',
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void setName(String value) {
    businessModel.name = value;
    update();
  }

  void setIndustry(String value) {
    businessModel.industry = value;
    update();
  }

  void setType(String value) {
    businessModel.type = value;
    update();
  }

  void setLocation(String value) {
    businessModel.location = value;
    update();
  }

  void setCurrency(String value) {
    businessModel.currency = value;
    update();
  }

  bool isLoading = false;
  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> saveBusinessDetails(BuildContext context) async {
    FocusScope.of(context).unfocus();
    formKey.currentState!.save();

    final bool isValid = formKey.currentState!.validate();

    if (!isValid) return;

    try {
      setIsLoading(true);
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('businesses')
            .doc(user.uid)
            .set(businessModel.toMap());

        // بعد الحفظ روح على الهوم
        Get.offAll(() => const HomeView());
      } else {
        // لو مافي يوزر (مفروض مستحيل توصل هون)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      print('Error saving business details: $e');
    } finally {
      setIsLoading(false);
    }
  }
}
