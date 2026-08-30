import 'dart:convert';
import 'package:get/get.dart';
import '../../app/controllers/app_update_controller.dart';
import '../../configuration/http_helpers.dart';
import '../../widgets/app_snackbar.dart';
import 'appointment_model.dart';

class AppointmentsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;

  late final int applicationId;

  @override
  void onInit() {
    super.onInit();
    applicationId = Get.arguments;
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;

      final response = await HttpHelper.gettData(
        url: 'applications/$applicationId/appointments',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        appointments.value = (data['data'] as List)
            .map((e) => AppointmentModel.fromJson(e))
            .where((item) => item.status != "cancelled")
            .toList();
      }
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String getTestName(AppointmentModel item) {
    return item.testName;
  }

  String getCode(AppointmentModel item) {
    return item.testCode;
  }

  String getStatus(AppointmentModel item) {
    return item.status;
  }

  String getDate(AppointmentModel item) {
    return item.date;
  }

  String getTime(AppointmentModel item) {
    return item.time;
  }

  String getLocation(AppointmentModel item) {
    return item.location;
  }

  String getAddress(AppointmentModel item) {
    return item.address;
  }

  String getResult(AppointmentModel item) {
    if (item.result == null) return "no_result".tr;
    return item.result!;
  }

  Future<void> cancelAppointment(int appointmentId) async {
    try {
      isLoading.value = true;

      final response = await HttpHelper.deleteData(
        url: "appointments/$appointmentId/cancel",
        body: {"cancellation_reason": "Schedule conflict"},
      );

      if (response.statusCode == 200) {
        appointments.removeWhere((item) => item.id == appointmentId);
        Get.find<AppUpdateController>().notifyChange();
        AppSnackbar.show("done".tr,
          "appointment_cancelled_successfully".tr,);
      }
    } catch (e) {
      Get.snackbar("error".tr,
        "failed_to_cancel_appointment".tr,);

      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  String getDay(AppointmentModel item) {
    try {
      final date = DateTime.parse(item.date);

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
        case DateTime.sunday:
          return "sunday".tr;
        default:
          return "";
      }
    } catch (e) {
      return "";
    }
  }
}
