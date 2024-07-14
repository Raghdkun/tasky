import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tasky/app/themes/app_text_theme.dart';
import './settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController()); 
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          child: ListTile(
            title: Text(
              "Reset database",
              style: AppTextStyles.base.w500.s18,
            ),
            onTap: (){
              controller.clearDatabase(); 
            },
          ),
        ),
      ),
    );
  }
}
