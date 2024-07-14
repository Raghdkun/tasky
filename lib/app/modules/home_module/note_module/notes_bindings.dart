import 'package:get/get.dart';
import 'package:tasky/app/modules/home_module/note_module/notes_controller.dart';

class NotesBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NotesController());
  }
}
