import 'package:get/get.dart';


class FavoritesController extends GetxController {
//   List<NoteModel> data = [];
//   bool? isFav;
//   DateTime? date = DateTime.now();

//   datenow() {
//     DateTime now = DateTime.now();
//     DateTime dateOnly = DateTime(now.year, now.month, now.day);
//     print(dateOnly);
//     return dateOnly;
//   }

// void loadFavoriteNotes() async {
//   final isar = await IsarService.instance.isar;

//   // Clear existing data (optional)
//   data.clear();

//   // Fetch notes where isFavorite is true
//   final notes = await isar.noteModels.where().filter().isFavoriteEqualTo(true).findAll();
//   data.addAll(notes);
// }

//   void toggleFavorite(int id) async {
//     final isar = await IsarService.instance.isar;
//     await isar.writeTxn(() async {
//       // Find the note with the given ID
//       final notes =
//           await isar.noteModels.where().filter().idEqualTo(id).findAll();
//           update();

//       if (notes.isNotEmpty) {
//         final note = notes.first; // Assuming only one note with the ID
//         // isFav = note.isFavorite = !note.isFavorite;
//         await isar.noteModels.put(note);
//         update();
//       } else {
//         // Handle the case where no note with the given ID exists (optional)
//         print("No note found with ID: $id"); // Example handling
//       }
//     });
//   }

//   void goToViewNote(index) {
//     Get.toNamed(AppRoutes.viewnote, arguments: {
//       "id": data[index].id,
//       "note_title": data[index].title,
//       "note_content": data[index].notecontent,
//       "color": data[index].color,
//       "date": date ?? datenow(),
//     });
//   }

//   void deleteNote(id) async {
//     final isar = await IsarService.instance.isar;

//     Get.defaultDialog(
//       title: "Delete note",
//       content: const Text("Are you sure that you want to delete this note?"),
//       textCancel: "no",
//       textConfirm: "yes",
//       onConfirm: () async {
//         await isar.writeTxn(() async => await isar.noteModels.delete(id));
//         update();
//         Get.close(0);
//         Get.offAllNamed(AppRoutes.home);
//       },
//     );
//   }

  @override
  void onInit() {
    // loadNotes(); 
    super.onInit();
  }
}
