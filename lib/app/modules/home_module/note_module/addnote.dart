import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tasky/app/modules/home_module/home_controller.dart';

class AddNote extends GetView<HomeController> {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.save),
                onPressed: () {
                  // controller.saveNote();
                  controller.plainText =
                      controller.quillController.document.toDelta().toJson();
                  String res = jsonEncode(controller.plainText);
                  controller.saveNote(res);

                  print(controller.plainText);
                }),
            // bottomSheet:
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize:
                    Size(Get.width, controller.istool ? 180.h : 25.h),
                child: Column(
                  children: [
                    controller.istool
                        ? FadeIn(
                            child: QuillProvider(
                              configurations: QuillConfigurations(
                                  controller: controller.quillController),
                              child: const QuillToolbar(
                                configurations: QuillToolbarConfigurations(
                                  buttonOptions: QuillToolbarButtonOptions(
                                      backgroundColor:
                                          QuillToolbarColorButtonOptions(),
                                      base: QuillToolbarBaseButtonOptions(
                                          iconTheme: QuillIconTheme(
                                              iconSelectedFillColor:
                                                  Colors.black))),
                                ),
                              ),
                            ),
                          )
                        : FadeOut(child: Container()),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        controller.istool = !controller.istool;
                        controller.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tools"),
                          Icon(controller.istool
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      controller.captureAndSaveWidget(
                          controller.screenshotController);
                    },
                    child: const Text(
                      "Save as image",
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
                          controller: controller.noteTitle,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter title here",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Screenshot(
                          controller: controller.screenshotController,
                          child: SizedBox(
                            height: Get.height,
                            child: QuillEditor.basic(
                              configurations: const QuillEditorConfigurations(
                                placeholder: "Type your note here",
                                readOnly: false,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
