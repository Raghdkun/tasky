import 'package:get/get.dart';
import 'package:tasky/app/modules/home_module/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        
      ),
    );
  }
}
