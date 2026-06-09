import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/appointment_slots/appointment_slots_controller.dart';

class DateSelector extends StatelessWidget {
  final AppointmentSlotsController controller;

  const DateSelector(this.controller, {super.key});

  String getDayName(DateTime date) {
    const days = [
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
      "الأحد",
    ];

    return days[date.weekday - 1];
  }

  String getMonthName(int month) {
    const months = [
      "",
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];

    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .16,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .04,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: controller.dates.length,
        itemBuilder: (_, index) {
          final dateString = controller.dates[index];
          final date = DateTime.parse(dateString);
          return Obx(
                () => GestureDetector(
              onTap: () {
                controller.selectedDate.value =
                    dateString;
              },
              child: Container(
                width: size.width * .20,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * .015,
                ),
                decoration: BoxDecoration(
                  color: controller.selectedDate.value ==
                      dateString
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      getDayName(date),
                      style: TextStyle(
                        fontSize:
                        size.width * .028,
                        color: controller
                            .selectedDate
                            .value ==
                            dateString
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),

                    SizedBox(
                        height: size.height * .005),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize:
                        size.width * .075,
                        color: controller
                            .selectedDate
                            .value ==
                            dateString
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(
                        height: size.height * .003),
                    Text(
                      getMonthName(date.month),
                      style: TextStyle(
                        fontSize:
                        size.width * .03,
                        color: controller
                            .selectedDate
                            .value ==
                            dateString
                            ? Colors.white70
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}