import 'package:get/get.dart';
import './favorites_controller.dart';

class FavoritesBindings extends Bindings {
    @override
    void dependencies() {
        Get.put(FavoritesController());
    }
}