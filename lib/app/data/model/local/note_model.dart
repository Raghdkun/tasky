import 'package:isar/isar.dart';

part 'note_model.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  String? title;
  String? notecontent;
  String? color ; 
  bool isfav = false ; 
  DateTime? date;


}
