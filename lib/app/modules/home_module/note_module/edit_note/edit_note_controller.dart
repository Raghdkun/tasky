import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:tasky/app/data/model/local/note_model.dart';
import 'package:tasky/app/routes/app_pages.dart';
import 'package:tasky/app/utils/isar_utils.dart';

class EditNoteController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  late QuillController quillController;
  dynamic plainText;
  dynamic id;
  String color = "" ; 
  DateTime? date ; 

  void initialMethod() async {
    List jsonDelta = jsonDecode(content.text);
    print(jsonDelta);
    final document = Document.fromJson(jsonDelta);

    quillController = QuillController(
        document: document,
        selection: const TextSelection(baseOffset: 0, extentOffset: 0));
  }

  @override
  void onInit() async {
    title.text = Get.arguments['note_name'];
    content.text = Get.arguments['notes_content'];
    color = Get.arguments['color'];

    date = Get.arguments['date'];

    id = Get.arguments['id'];

    initialMethod();

    super.onInit();
  }

  void updateNote(
    String plainText,
  ) async {
    final isar = await IsarService.instance.isar;
    // DateTime now = DateTime.now();
    // DateTime dateOnly = DateTime(now.year, now.month, now.day);

    final note = NoteModel()
      ..id = id // Set the ID of the note to update
      ..title = title.text
      ..notecontent = plainText
      ..color = color
      ..date = date;

    await isar.writeTxn(() async => await isar.noteModels.put(note));
    Get.offAllNamed(AppRoutes.home);
  }

  void saveNote(plainText) {
    updateNote(plainText);
    Get.defaultDialog(content: const Text("done"));
  }
}
