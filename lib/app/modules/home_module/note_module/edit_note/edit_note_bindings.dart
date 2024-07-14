import 'package:get/get.dart';
import './edit_note_controller.dart';

class EditNoteBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(EditNoteController());
    }
}