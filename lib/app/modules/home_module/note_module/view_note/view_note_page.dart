import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './view_note_controller.dart';

class ViewNotePage extends GetWidget<ViewNoteController> {
  const ViewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(controller.title),
            actions: [TextButton(onPressed: (){
              controller.goToEditNote(); 
            }, child: Text("Edit"))],
          ),
          SliverToBoxAdapter(
            child: QuillProvider(
              configurations: QuillConfigurations(
                controller: controller.quillController,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('en'),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: true,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
