import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:tasky/app/routes/app_pages.dart';

class ViewNoteController extends GetxController {
  dynamic id;
  String title = "";
  String content = "";
  String color = "" ; 
  DateTime date = DateTime.now();

  late QuillController quillController;

  void initialMethod() {
    title = Get.arguments['note_title'];
    content = Get.arguments['note_content'];
    id = Get.arguments["id"];
    color = Get.arguments["color"];

    date = Get.arguments["date"];

    List jsonDelta = jsonDecode(content);
    print(jsonDelta);
    final document = Document.fromJson(jsonDelta);

    quillController = QuillController(
        document: document,
        selection: const TextSelection(baseOffset: 0, extentOffset: 0));
  }

  void goToEditNote() {
    Get.toNamed(AppRoutes.editnote, arguments: {
      "id": id,
      "note_name": title,
      "notes_content": Get.arguments['note_content'],
      "color" : color, 
      "date": date
    });
  }

  @override
  void onInit() {
    initialMethod();
    super.onInit();
  }
}
