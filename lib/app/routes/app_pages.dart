import 'package:get/get.dart';
import 'package:tasky/app/modules/favorites/favorites_bindings.dart';
import 'package:tasky/app/modules/favorites/favorites_page.dart';
import 'package:tasky/app/modules/home_module/home_binding.dart';
import 'package:tasky/app/modules/home_module/home_page.dart';
import 'package:tasky/app/modules/home_module/note_module/addnote.dart';
import 'package:tasky/app/modules/home_module/note_module/edit_note/edit_note_bindings.dart';
import 'package:tasky/app/modules/home_module/note_module/edit_note/edit_note_page.dart';
import 'package:tasky/app/modules/home_module/note_module/view_note/view_note_bindings.dart';
import 'package:tasky/app/modules/home_module/note_module/view_note/view_note_page.dart';
import 'package:tasky/app/modules/settings/settings_bindings.dart';
import 'package:tasky/app/modules/settings/settings_page.dart';
import 'package:tasky/app/modules/splash_module/splash_page.dart';
part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      transition: Transition.fadeIn,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.addnotes,
      transition: Transition.fadeIn,
      page: () => const AddNote(),
    ),
    GetPage(
        name: AppRoutes.viewnote,
        transition: Transition.fadeIn,
        page: () => const ViewNotePage(),
        binding: ViewNoteBindings()),
    GetPage(
        name: AppRoutes.editnote,
        page: () => const EditNotePage(),
        binding: EditNoteBindings()),
    GetPage(
        name: AppRoutes.settings,
        transition: Transition.fadeIn,
        page: () => const SettingsPage(),
        binding: SettingsBindings()),
    GetPage(
        name: AppRoutes.favorites,
        transition: Transition.fadeIn,
        page: () => const FavoritesPage(),
        binding: FavoritesBindings()),
  ];
}
