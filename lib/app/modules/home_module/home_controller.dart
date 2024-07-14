import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:tasky/app/data/model/local/note_model.dart';
import 'package:tasky/app/modules/favorites/favorites_page.dart';
import 'package:tasky/app/modules/home_module/note_module/home_notes.dart';
import 'package:tasky/app/modules/settings/settings_page.dart';
import 'package:tasky/app/routes/app_pages.dart';
import 'package:tasky/app/utils/isar_utils.dart';

class HomeController extends GetxController {
  ScrollController scrollController = ScrollController();
  final isarbase = IsarService.instance.isar;

// late Isar isarInstance ;
  DateTime? date;

  bool isFav = false;

  bool istool = false;

  int navBarIndex = 0;

  FocusNode focusNode = FocusNode();

  dynamic plainText;
  ScreenshotController screenshotController = ScreenshotController();

  QuillController quillController = QuillController.basic();
  TextEditingController noteTitle = TextEditingController();

  List<String> noteColors = [
    "c4b53b",
    "3BC471",
    "3B4AC4",
    "C43B8E",
    "7EA45B",
    "5BA3A4",
    "815BA4",
    "A45C5B",
    "678898",
    "8F6798",
    "987767",
    "9C8163",
    "9C639B",
  ];
  String hexColor = "c4b53b";
  findColor() {
    // Create a copy of the original list to avoid modifying it
    List<String> shuffledColors = List.from(noteColors);

    // Shuffle the copied list
    shuffledColors.shuffle(math.Random());

    // Safely get the first element (with error handling)
    String colorCode = shuffledColors[0];

    // Convert the color code to a Color object, handling potential errors
    // String color;

    return colorCode;
  }

  Future<String?> captureAndSaveWidget(
      ScreenshotController screenshotController) async {
    // 1. Capture the widget as an image
    final imageData = await screenshotController.capture(
        delay: const Duration(
            milliseconds: 100)); // Optional delay for dynamic content

    if (imageData == null) {
      return null; // Handle capture failure gracefully
    }

    // 2. Get the external storage directory (consider permission handling)
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw PlatformException(
          code: 'StorageError', message: 'Failed to access external storage');
    }

    // 3. Create the "notes" folder (handle potential errors)
    final notesDir = Directory('${directory.path}/notes');
    if (!await notesDir.exists()) {
      try {
        await notesDir.create();
      } catch (error) {
        throw PlatformException(
            code: 'FolderCreationError',
            message: 'Failed to create "notes" folder: $error');
      }
    }

    // 4. Generate a unique filename (timestamp-based)
    final filename = '${DateTime.now().millisecondsSinceEpoch}.png';

    // 5. Save the image to the "notes" folder
    final imagePath = '${notesDir.path}/$filename';
    final file = File(imagePath);
    await file.writeAsBytes(imageData);
    Fluttertoast.showToast(
        msg: "Image Saved",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );

    return imagePath; // Return the saved image path for potential usage
  }

  List<BottomBarItem> bottomBarItemList = [
    BottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text("Home"),
        selectedColor: const Color(0xFF006C4B)),
    BottomBarItem(
        icon: const Icon(Icons.star),
        title: const Text("Favorites"),
        selectedColor: const Color(0xFF006C4B)),
    BottomBarItem(
        icon: const Icon(Icons.settings),
        title: const Text("Settings"),
        selectedColor: const Color(0xFF006C4B)),
  ];

  List<Widget> pagesList = [
    const HomeNotes(),
    const FavoritesPage(),
    const SettingsPage(),
  ];

  changeNavItems(value) {
    navBarIndex = value;
    update();
  }

  List<NoteModel> data = [];
  List<NoteModel> filteredData = [];

  @override
  void onInit() {
    super.onInit();
    loadNotes();
    // loadAllFavoriteNotes();
    // initiLoadNotes(); // Load notes on controller initialization
  }

  void loadNotes() async {
    final isar = await IsarService.instance.isar;
    print(findColor());
    // Clear existing notes to avoid duplicates
    data.clear();

    // Filter notes by desired date (if needed)
    final query =
        isar.noteModels.where().filter().dateEqualTo(date ?? datenow());
    // Filter by specific date if provided
    // Fetch all filtered notes
    final notes = await query.findAll();

    // Sort notes by date in ascending order within code
    notes.sort((note1, note2) => note1.date!.compareTo(note2.date!));
    data.addAll(notes);
    loadAllFavoriteNotes();

    update();
  }

  void initiLoadNotes() async {
    final isar = await IsarService.instance.isar;

    // Clear existing notes to avoid duplicates
    data.clear();
    // Filter notes by desired date (if needed)
    final query = isar.noteModels.where().filter().dateEqualTo(datenow());
    // Filter by specific date if provided
    // Fetch all filtered notes
    final notes = await query.findAll();

    // Sort notes by date in ascending order within code
    notes.sort((note1, note2) => note1.date!.compareTo(note2.date!));
    data.addAll(notes);
    update();
  }

  void loadAllFavoriteNotes() async {
    final isar = await IsarService.instance.isar;

    // Clear existing data (optional)

    // Fetch all notes
    final notes = await isar.noteModels.filter().isfavEqualTo(true).findAll();
    filteredData.clear();
    filteredData.addAll(notes);

    update();
  }

  datenow() {
    DateTime now = DateTime.now();
    DateTime dateOnly = DateTime(now.year, now.month, now.day);
    print(dateOnly);
    return dateOnly;
  }

  void toggleFavorite(int id) async {
    final isar = await IsarService.instance.isar;
    final result = await isar.noteModels.filter().idEqualTo(id).findFirst();
    await isar.writeTxn(() async {
      result!.isfav = !result.isfav;

      await isar.noteModels.put(result);
      update();
      print(
          'Favorite state for note $id updated to: ${result.isfav}'); // Print updated value
    });
    loadNotes();
    loadAllFavoriteNotes();
  }

  void addNote(plainText) async {
    final isar = await IsarService.instance.isar;
    DateTime now = DateTime.now();
    DateTime dateOnly = DateTime(now.year, now.month, now.day);

    final note = NoteModel()
      ..title = noteTitle.text
      ..notecontent = plainText
      ..color = findColor()
      ..isfav = false
      ..date = date ?? dateOnly;
    if (noteTitle.text.isNotEmpty) {
      await isar.writeTxn(() async => await isar.noteModels.put(note));
      // quillController.plainTextEditingValue.text

      Get.offAllNamed(AppRoutes.home);
      update();
    } else {
      Get.defaultDialog(
          content:
              const Text("Note title or note content should not be empty"));
    }
  }

  void updateNote(idTitle) async {
    final isar = await IsarService.instance.isar;

    final note = NoteModel()
      ..title = noteTitle.text
      ..notecontent = plainText
      ..date = DateTime.now();

    await isar
        .writeTxn(() async => await isar.noteModels.putByIndex(idTitle, note));
  }

  void deleteNote(id) async {
    final isar = await IsarService.instance.isar;

    Get.defaultDialog(
      title: "Delete note",
      content: const Text("Are you sure that you want to delete this note?"),
      textCancel: "no",
      textConfirm: "yes",
      onConfirm: () async {
        await isar.writeTxn(() async => await isar.noteModels.delete(id));
        update();
        Get.close(0);
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  void goToViewNote(index) {
    Get.toNamed(AppRoutes.viewnote, arguments: {
      "id": data[index].id,
      "note_title": data[index].title,
      "note_content": data[index].notecontent,
      "color": data[index].color,
      "date": date ?? datenow(),
    });
  }

  void saveNote(plainText) {
    addNote(plainText);
  }
}
