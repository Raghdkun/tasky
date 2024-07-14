import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/app/modules/home_module/home_controller.dart';
import 'package:tasky/app/utils/widgets/bottom_nav_bar.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return NavBar(
            currentIndex: controller.navBarIndex,
            items: controller.bottomBarItemList,
            onTap: (value) {
              controller.changeNavItems(value);
            },
          );
        },
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) =>
            controller.pagesList.elementAt(controller.navBarIndex),
      ),

    );
  }
}
