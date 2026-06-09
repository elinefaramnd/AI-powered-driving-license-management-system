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
        "text": "غير متاح حالياً",
      };
    }
    if (test["passed"] == true) {
      return {
        "status": "done",
        "text": "تم اجتياز الاختبار",
      };
    }

    if (test["has_active_appointment"] == true) {
      return {
        "status": "booked",
        "text": "لديك موعد مجدول",
      };
    }

    if (test["can_book"] == true &&
        test["is_available"] == true) {
      String bookingText = "يمكنك حجز موعد الاختبار الآن";
      switch (code) {
        case "vision":
          bookingText = "يمكنك حجز موعد اختبار النظر الآن";
          break;
        case "theory":
          bookingText = "يمكنك حجز موعد الاختبار النظري الآن";
          break;
        case "practical":
          bookingText = "يمكنك حجز موعد الاختبار العملي الآن";
          break;
      }
      return {
        "status": "available",
        "text": bookingText,
      };
    }
    String waitingText = "غير متاح حالياً";
    switch (code) {
      case "vision":
        waitingText = "بانتظار استكمال متطلبات الطلب";
        break;
      case "theory":
        waitingText = "بانتظار اجتياز اختبار النظر";
        break;
      case "practical":
        waitingText = "بانتظار اجتياز الاختبار النظري";
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
        return "اختبار النظر";
      case "theory":
        return "الاختبار النظري";
      case "practical":
        return "الاختبار العملي";
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
      return "الطلب لم يصل لمرحلة الاختبارات بعد";
    }
    if (reason.contains(" عملية الدفع")) {
      return "لا يمكن الحجز قبل إكمال عملية الدفع";
    }
    return "${reason.length > 40 ? reason.substring(0, 40) + "..." : reason}";
  }
}
