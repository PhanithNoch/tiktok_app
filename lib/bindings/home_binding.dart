import 'package:get/get.dart';
import 'package:tiktok_app/controllers/auth_controller.dart';
import 'package:tiktok_app/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
