import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/appointment_slots/appointment_slots_page.dart';
import '../../modules/my_appointments/my_appointments_controller.dart';
import 'appointment_footer_section.dart';
import 'appointment_info_section.dart';
import 'appointment_location_section.dart';
import 'appointment_top_section.dart';

class AppointmentCard extends StatelessWidget {
  final dynamic item;
  final AppointmentsController controller;
  final bool completed;

  const AppointmentCard({
    super.key,
    required this.item,
    required this.controller,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .018,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          size.width * .035,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: size.width * .02,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: size.width * .015,
              decoration: BoxDecoration(
                color: completed
                    ? AppColors.primaryColor
                    : AppColors.gold,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    size.width * .035,
                  ),
                  bottomRight: Radius.circular(
                    size.width * .035,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  size.width * .03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentTopSection(
                      code: controller.getCode(item),
                      title: controller.getTestName(item),
                    ),

                    SizedBox(
                      height: size.height * .008,
                    ),

                    const Divider(),

                    SizedBox(
                      height: size.height * .008,
                    ),

                    AppointmentInfoSection(
                      date: controller.getDate(item),
                      day: controller.getDay(item),
                      time: controller.getTime(item),
                    ),

                    SizedBox(
                      height: size.height * .012,
                    ),

                    const Divider(),

                    SizedBox(
                      height: size.height * .012,
                    ),

                    AppointmentLocationSection(
                      location:
                      controller.getLocation(item),
                    ),

                    SizedBox(
                      height: size.height * .012,
                    ),

                    AppointmentFooterSection(
                      completed: completed,
                      result: controller.getResult(item),
                        onEdit: () async {
                          final result = await Get.to(
                                () => AppointmentSlotsPage(
                              testTypeId: item.testTypeId,
                              applicationId: item.applicationId,
                              isReschedule: true,
                              appointmentId: item.id,
                            ),
                          );

                          if (result == true) {
                            await controller.fetchAppointments();
                          }
                        },
                        onCancel: () {
                          controller.cancelAppointment(item.id);
                        }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}