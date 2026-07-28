import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/appointment_slots/appointment_slots_controller.dart';

class DateSelector extends StatelessWidget {
  final AppointmentSlotsController controller;

  const DateSelector(this.controller, {super.key});

  String getDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return "monday".tr;
      case DateTime.tuesday:
        return "tuesday".tr;
      case DateTime.wednesday:
        return "wednesday".tr;
      case DateTime.thursday:
        return "thursday".tr;
      case DateTime.friday:
        return "friday".tr;
      case DateTime.saturday:
        return "saturday".tr;
      default:
        return "sunday".tr;
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "january".tr;
      case 2:
        return "february".tr;
      case 3:
        return "march".tr;
      case 4:
        return "april".tr;
      case 5:
        return "may".tr;
      case 6:
        return "june".tr;
      case 7:
        return "july".tr;
      case 8:
        return "august".tr;
      case 9:
        return "september".tr;
      case 10:
        return "october".tr;
      case 11:
        return "november".tr;
      default:
        return "december".tr;
    }
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