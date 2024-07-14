import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/app/modules/home_module/home_controller.dart';
import 'package:tasky/app/routes/app_pages.dart';
import 'package:tasky/app/themes/app_text_theme.dart';

class HomeNotes extends GetWidget<HomeController> {
  const HomeNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  // color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "Search for a note",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Hello",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: EasyDateTimeLine(
                              initialDate: controller.datenow(),
                              //make sec load for timeline have the date now and for choose
                              activeColor: const Color(0xFF003257),
                              headerProps: const EasyHeaderProps(
                                  selectedDateStyle:
                                      TextStyle(color: Colors.white)),
                              dayProps: const EasyDayProps(
                                  dayStructure: DayStructure.dayStrDayNum,
                                  inactiveDayStyle: DayStyle(
                                      dayNumStyle:
                                          TextStyle(color: Colors.white)),
                                  activeDayStyle: DayStyle(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF003257),
                                          Color(0xFF00497C),
                                        ],
                                      ),
                                    ),
                                  ),
                                  todayStyle: DayStyle(
                                      dayNumStyle: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                              locale: "en",
                              onDateChange: (selectedDate) {
                                //`selectedDate` the new date selected.
                                controller.date = selectedDate;
                                controller.loadNotes();
                                controller.loadAllFavoriteNotes();
                                controller.update();
                                print("jjj ${controller.datenow()}");
                                print(selectedDate);
                                print(controller.date);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              // height: Get.height,
                              child: controller.data.isEmpty
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: Transform.translate(
                                        offset: const Offset(0, 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              "No notes found for this day",
                                              style: AppTextStyles.base.s16.w700,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      controller: controller.scrollController,
                                      shrinkWrap: true,
                                      itemCount: controller.data.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.8),
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
                                                        BorderRadius.circular(
                                                            30)),
                                                color: Color(int.parse(
                                                    "0xFF${controller.data[index].color}")),
                                                child: Center(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    controller
                                                        .data[index].title!,
                                                    style: AppTextStyles
                                                        .base.w400.s18,
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                )),
                                              ),
                                              GetBuilder<HomeController>(
                                                builder: (controller) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Transform.translate(
                                                        offset:
                                                            const Offset(0, 15),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              controller.deleteNote(
                                                                  controller
                                                                      .data[
                                                                          index]
                                                                      .id);
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete)),
                                                      ),
                                                      Transform.translate(
                                                        offset:
                                                            const Offset(0, 15),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .toggleFavorite(
                                                                controller
                                                                    .data[index]
                                                                    .id,
                                                              );
                                                              controller
                                                                  .update();
                                                            },
                                                            icon: controller
                                                                        .data[
                                                                            index]
                                                                        .isfav ==
                                                                    true
                                                                ? const Icon(
                                                                    Icons.star)
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
                                    ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // controller.date = controller.datenow();
                  controller.loadNotes();

                  Get.toNamed(AppRoutes.addnotes);
                },
                child: const Icon(Icons.add),
              ),
            ));
  }
}
