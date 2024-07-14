import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tasky/app/modules/home_module/home_controller.dart';
import 'package:tasky/app/themes/app_text_theme.dart';

class FavoritesPage extends GetView<HomeController> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // height: Get.height,
                    child: controller.filteredData.isEmpty
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "No notes found for this day",
                              style: AppTextStyles.base.s16.w700,
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredData.length ,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.8),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.goToViewNote(index);
                              },
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      color: Color(int.parse(
                                          "0xFF${controller.filteredData[index].color}")),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: 
                                         Text(
                                          controller.filteredData[index].title!,
                                          style: AppTextStyles.base.w400.s18,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                        ),
                                      )),
                                    ),
                                    GetBuilder<HomeController>(
                                      builder: (controller) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(0, 15),
                                              child: IconButton(
                                                  onPressed: () {
                                                    controller.deleteNote(
                                                        controller
                                                            .filteredData[index].id);
                                                  },
                                                  icon: const Icon(Icons.delete)),
                                            ),
                                            Transform.translate(
                                              offset: const Offset(0, 15),
                                              child: IconButton(
                                                  onPressed: () {
                                                    controller.toggleFavorite(
                                                      controller.filteredData[index].id,
                                                    );
                                                    controller.update();
                                                  },
                                                  icon: controller.filteredData[index]
                                                              .isfav ==
                                                          true
                                                      ? const Icon(Icons.star)
                                                      : const Icon(Icons
                                                          .star_border_outlined)),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
