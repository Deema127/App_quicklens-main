



import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCrl());
   
  }
}
