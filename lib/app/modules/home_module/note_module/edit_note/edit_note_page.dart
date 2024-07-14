import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './edit_note_controller.dart';

class EditNotePage extends GetView<EditNoteController> {
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: QuillProvider(
          configurations:
              QuillConfigurations(controller: controller.quillController),
          child: const QuillToolbar(
            configurations: QuillToolbarConfigurations(
              buttonOptions: QuillToolbarButtonOptions(
                  backgroundColor: QuillToolbarColorButtonOptions(),
                  base: QuillToolbarBaseButtonOptions(
                      iconTheme:
                          QuillIconTheme(iconSelectedFillColor: Colors.black))),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  // controller.saveNote();
                  controller.plainText =
                      controller.quillController.document.toDelta().toJson();
                    String res =   jsonEncode(controller.plainText);
                      controller.saveNote(res);

                  // print(controller.plainText);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: QuillProvider(
              configurations: QuillConfigurations(
                controller: controller.quillController,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('en'),
                ),
              ),
              child: SizedBox(
                height: Get.height,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: controller.title,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter title here",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: Get.height,
                      child: QuillEditor.basic(
                        configurations: const QuillEditorConfigurations(
                          readOnly: false,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
