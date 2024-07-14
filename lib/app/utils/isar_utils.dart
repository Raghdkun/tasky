import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/app/data/model/local/note_model.dart';

class IsarService {
  static final IsarService _instance = IsarService._();
  static IsarService get instance => _instance;

  final Future<Isar> _isarFuture;

  IsarService._()
      : _isarFuture = _initIsar(); // Replace with static Future<Isar>

  static Future<Isar> _initIsar() async {
    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Open Isar with the directory path
    return await Isar.open([NoteModelSchema], directory: directory.path);
  }

  Future<Isar> get isar async => await _isarFuture;
}
