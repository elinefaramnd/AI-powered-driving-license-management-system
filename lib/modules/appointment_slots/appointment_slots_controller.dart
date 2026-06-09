import 'dart:convert';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../configuration/http_helpers.dart';

class AppointmentSlotsController extends GetxController {
  final int testTypeId;
  final int applicationId;
  RxBool bookingLoading = false.obs;

  AppointmentSlotsController({
    required this.testTypeId,
    required this.applicationId,
  });

  RxBool loading = true.obs;
  RxList slots = [].obs;
  RxString selectedDate = ''.obs;
  RxInt selectedSlotId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSlots();
  }
  Future<void> loadSlots() async {
    loading.value = true;
    final res = await HttpHelper.gettData(
      url: 'appointment-slots?test_type_id=$testTypeId',
    );
    final decoded = jsonDecode(res.body);
    if (decoded["success"] == true) {
      slots.assignAll(decoded["data"]);
      if (slots.isNotEmpty) {
        selectedDate.value = slots.first["date"];
      }
    }
    loading.value = false;
  }
  List get dates {
    return slots
        .map((e) => e["date"])
        .toSet()
        .toList();
  }
  List get filteredSlots {
    return slots
        .where(
          (e) => e["date"] == selectedDate.value,
    )
        .toList();
  }
  Future<void> openMap(String url) async {
    print("MAP URL = $url");
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
  Future<void> bookAppointment() async {
    if (selectedSlotId.value == 0) return;

    bookingLoading.value = true;

    try {
      final res = await HttpHelper.postData(
        url: 'applications/$applicationId/appointments',
        body: {
          "appointment_slot_id": selectedSlotId.value.toString(),
        },
      );

      final decoded = jsonDecode(res.body);

      bookingLoading.value = false;

      if (decoded["success"] == true) {
        Get.back(result: true);
        Get.snackbar(
          "تم الحجز",
          "تم حجز الموعد بنجاح",
          snackPosition: SnackPosition.TOP,
        );

        print(res.body);
      }else{
        Get.snackbar(
          " خطأ",
          decoded['message'],
          snackPosition: SnackPosition.TOP,
        );

        print(res.body);
      }
    } catch (e) {
      bookingLoading.value = false;
    }
  }
}