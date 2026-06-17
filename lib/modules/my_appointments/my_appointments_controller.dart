import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
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

  String getResult(AppointmentModel item) {
    return item.result ?? "";
  }

  String getDay(AppointmentModel item) {
    try {
      final date = DateTime.parse(item.date);

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
    } catch (e) {
      return "";
    }
  }
}
