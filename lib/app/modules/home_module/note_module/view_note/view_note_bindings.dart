import 'package:get/get.dart';
import './view_note_controller.dart';

class ViewNoteBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ViewNoteController());
    }
}