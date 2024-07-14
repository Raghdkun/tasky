import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/app/data/model/local/note_model.dart';

class NotesController extends GetxController {
    ScrollController scrollController = ScrollController();

  RxList<NoteModel> data = RxList<NoteModel>();



  // void addNote() async {
  //   final note = NoteModel()..title = 
  // }

  void updateNote() async {
  }

  void deleteNote() async {
  }

  void selectNote() {}
}
