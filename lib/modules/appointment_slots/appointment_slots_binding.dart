import 'package:get/get.dart';

import 'appointment_slots_controller.dart';

class AppointmentSlotsBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;

    Get.lazyPut<AppointmentSlotsController>(
          () => AppointmentSlotsController(
        testTypeId: args["testTypeId"],
        applicationId: args["applicationId"],
        isReschedule: args["isReschedule"] ?? false,
        appointmentId: args["appointmentId"],
      ),
    );
  }
}