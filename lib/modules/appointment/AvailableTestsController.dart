import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';

class AvailableTestsController extends GetxController {
  late int applicationId;
  RxBool loading = false.obs;
  RxList tests = [].obs;
  RxList appointments = [].obs;
  RxList results = [].obs;
  RxBool feePaid = false.obs;
  @override
  void onInit() {
    super.onInit();

    applicationId = Get.arguments ?? 0;

    print("APPLICATION ID = $applicationId");

    loadAll();
  }
  Future<void> loadAll() async {
    loading.value = true;
    await loadTests();

    loading.value = false;
  }
  Future<void> loadTests() async {
    final res = await HttpHelper.gettData(
      url: 'applications/$applicationId/available-tests',
    );

    final decoded = jsonDecode(res.body);
    print(decoded);
    if (decoded["success"] == true) {
      tests.assignAll(decoded["data"]["tests"]);
    }
  }
  Map<String, dynamic> getTestState(String code) {
    final test = tests.firstWhereOrNull(
          (e) => e["code"] == code,
    );
    if (test == null) {
      return {
        "status": "locked",
        "text": "currently_unavailable".tr,
      };
    }
    if (test["passed"] == true) {
      return {
        "status": "done",
        "text": "test_passed".tr,
      };
    }

    if (test["has_active_appointment"] == true) {
      return {
        "status": "booked",
        "text": "scheduled_appointment".tr,
      };
    }

    if (test["can_book"] == true &&
        test["is_available"] == true) {
      String bookingText = "book_test_now".tr;
      switch (code) {
        case "vision":
          bookingText = "book_vision_test_now".tr;
          break;
        case "theory":
          bookingText = "book_theory_test_now".tr;
          break;
        case "practical":
          bookingText = "book_practical_test_now".tr;
          break;
      }
      return {
        "status": "available",
        "text": bookingText,
      };
    }
    String waitingText = "currently_unavailable".tr;
    switch (code) {
      case "vision":
        waitingText = "waiting_application_requirements".tr;
        break;
      case "theory":
        waitingText =  "waiting_vision_test".tr;
        break;
      case "practical":
        waitingText = "waiting_theory_test".tr;
        break;
    }
    return {
      "status": "locked",
      "text": waitingText,
      "reason": test["reason"] ?? "",
    };
  }
  String getArabicName(String code) {
    switch (code) {
      case "vision":
        return "vision_test".tr;
      case "theory":
        return "theory_test".tr;
      case "practical":
        return "practical_test".tr;
      default:
        return "";
    }
  }
  IconData getIcon(String code) {
    switch (code) {
      case "vision":
        return Icons.remove_red_eye_outlined;
      case "theory":
        return Icons.menu_book_outlined;
      case "practical":
        return Icons.drive_eta_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }
  String formatReason(String? reason) {
    if (reason == null || reason.isEmpty) return "";
    if (reason.contains("ليس في مرحلة الاختبارات")) {
      return "application_not_in_tests_stage".tr;
    }
    if (reason.contains(" عملية الدفع")) {
      return "complete_payment_first".tr;
    }
    return "${reason.length > 40 ? reason.substring(0, 40) + "..." : reason}";
  }
  String getCurrentAvailableTest() {
    final test = tests.firstWhereOrNull(
          (e) =>
      e["can_book"] == true &&
          e["is_available"] == true,
    );
    if (test == null) {
      return "no_available_test".tr;
    }
    return getArabicName(test["code"]);
  }
}
