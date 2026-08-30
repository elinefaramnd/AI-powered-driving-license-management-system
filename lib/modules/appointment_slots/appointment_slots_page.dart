import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/appointment_slots_widget/center_card.dart';
import '../../widgets/appointment_slots_widget/center_map_card.dart';
import '../../widgets/appointment_slots_widget/confirm_booking_button.dart';
import '../../widgets/appointment_slots_widget/date_selector.dart';
import '../../widgets/appointment_slots_widget/slot_card.dart';
import '../../widgets/custom_app_bar.dart';
import 'appointment_slots_controller.dart';

class AppointmentSlotsPage extends StatelessWidget {
  final int testTypeId;
  final int applicationId;

  final bool isReschedule;
  final int? appointmentId;
  const AppointmentSlotsPage({
    super.key,
    required this.testTypeId,
    required this.applicationId,
    this.isReschedule = false,
    this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(
      AppointmentSlotsController(
        testTypeId: testTypeId,
        applicationId: applicationId,
        isReschedule: isReschedule,
        appointmentId: appointmentId,
      ),
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.isReschedule
            ? "edit_test_appointment".tr
            : "book_test_appointment".tr,
      ),
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (controller.slots.isEmpty) {
          return Center(child: Text("no_available_slots".tr));
        }
        final firstSlot = controller.slots.first;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height * .02),
                    CenterCard(
                      testName: firstSlot["test_type"]["name"],
                      centerName: firstSlot["center"]["name"],
                    ),
                    SizedBox(height: size.height * .025),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                      ),
                      child: Row(
                        // textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: size.width * .02),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "select_date".tr,
                              style: TextStyle(
                                fontSize: size.width * .042,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * .015),
                    DateSelector(controller),
                    SizedBox(height: size.height * .025),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: size.width * .02),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "select_available_period".tr,
                              style: TextStyle(
                                fontSize: size.width * .042,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * .015),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .04,
                        ),
                        itemCount: controller.filteredSlots.length,
                        itemBuilder: (_, index) {
                          final slot = controller.filteredSlots[index];
                          return Obx(
                            () => SlotCard(
                              slot: slot,
                              selected:
                                  controller.selectedSlotId.value == slot["id"],
                              onTap: () {
                                controller.selectedSlotId.value = slot["id"];
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * .02),
                    CenterMapCard(
                      center: firstSlot["center"],
                      onMapPressed: () {
                        controller.openMap(firstSlot["center"]["map_url"]);
                      },
                    ),
                    SizedBox(height: size.height * .025),
                    Obx(
                      () => ConfirmBookingButton(
                        enabled: controller.selectedSlotId.value != 0,
                        isLoading: controller.bookingLoading.value,
                        onPressed: () {
                          if (controller.isReschedule) {
                            controller.rescheduleAppointment();
                          } else {
                            controller.bookAppointment();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size.height * .03),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
