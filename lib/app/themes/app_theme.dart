import 'package:flutter/material.dart';
import 'package:tasky/app/themes/color_schema.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData themData = ThemeData(
colorScheme: darkColorScheme,
    useMaterial3: true,
  );
}
