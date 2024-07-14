import 'package:get/get.dart';
import 'package:tasky/app/routes/app_pages.dart';
import 'package:tasky/app/utils/isar_utils.dart';

class SettingsController extends GetxController {

void clearDatabase() async {
  final isar = await IsarService.instance.isar;
  await isar.writeTxn(() async => await isar.clear());
  Get.offAllNamed(AppRoutes.home); 
}
}