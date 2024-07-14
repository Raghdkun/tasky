

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tasky/app/routes/app_pages.dart';
import 'package:tasky/app/themes/app_theme.dart';
import 'package:tasky/app/translations/app_translations.dart';
import 'package:tasky/app/utils/common.dart';
import 'package:tasky/app/utils/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    "Your device locale: ${Get.deviceLocale}".logStr(name: 'Locale');
    return GestureDetector(
      // Dismiss keyboard when clicked outside
      onTap: () => Common.dismissKeyboard(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          initialRoute: AppRoutes.initial,
          theme: AppThemes.themData,
          getPages: AppPages.pages,
          locale: AppTranslation.locale,
          translationsKeys: AppTranslation.translations,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
