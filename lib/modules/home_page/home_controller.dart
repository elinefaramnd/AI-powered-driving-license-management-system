import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/configuration/http_helpers.dart' show HttpHelper;
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app/controllers/app_update_controller.dart';
import '../create_application/create_application_step1.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool get canUseServices => profileStatus.value == "approved";
  RxBool loadingOrder = false.obs;
  RxBool hasApplication = true.obs;
  RxInt applicationId = 0.obs;
  RxString currentApplicationNumber = "-".obs;
  RxString currentApplicationStatus = "-".obs;
  RxString currentService = "-".obs;
  RxString status = '-'.obs;
  RxBool loadingServices = false.obs;
  var isServicesExpanded = false.obs;
  var profileStatus = "".obs;
  RxList<Map<String, dynamic>> services = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var notificationsCount = 3.obs;
  RxString profileRejectionReason = "".obs;
  RxBool loadingHome = true.obs;
  final appUpdate = Get.find<AppUpdateController>();
  @override
  void onInit() {
    super.onInit();
    loadHome();
    ever(appUpdate.homeRefresh, (_) async {
      await loadHome();
    });
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void selectMenu(int index) {
    selectedIndex.value = index;
  }

  void openNewApplication() {
    Get.to(() => CreateApplicationStep1());
  }

  void openUpdateProfile() {
    Get.toNamed(
      "/updatePro",
      arguments: {"mode": "rejected", "reason": profileRejectionReason.value},
    );
  }

  void openCompleteProfile() {
    Get.toNamed("/completePro");
  }

  void openOrderDetails() {
    if (applicationId.value == 0) {
      return;
    }
    Get.toNamed("/available_tests_page", arguments: applicationId.value);
  }

  void openUploadDocuments() {
    if (applicationId.value <= 0) {
      AppSnackbar.show("تنبيه", "لا يوجد طلب حالياً");
      return;
    }
    Get.toNamed("/upload_documents", arguments: applicationId.value);
  }

  Future<void> getCurrentApplication() async {
    try {
      loadingOrder.value = true;
      final listResponse = await HttpHelper.gettData(
        url: "applications?per_page=15",
      );
      final listData = jsonDecode(listResponse.body);
      if (listResponse.statusCode != 200) {
        return;
      }
      final items = listData["data"]["items"];
      if (items.isEmpty) {
        hasApplication.value = false;
        currentApplicationNumber.value = "";
        currentApplicationStatus.value = "";
        currentService.value = "";
        return;
      }
      applicationId.value = items[0]["id"];
      hasApplication.value = true;
      print("APPLICATION ID => ${applicationId.value}");
      final details = await HttpHelper.gettData(
        url: "applications/${applicationId.value}",
      );
      print(details.body);
      if (details.statusCode != 200) {
        hasApplication.value = false;
        return;
      }
      final app = jsonDecode(details.body)["data"];
      currentApplicationNumber.value = app["application_number"];

      currentApplicationStatus.value = app["status"];

      currentService.value = app["service_type"]["name"];
    } catch (e) {
      print(e);
    } finally {
      loadingOrder.value = false;
    }
  }

  Future<void> getServices() async {
    try {
      loadingServices.value = true;
      final response = await HttpHelper.gettData(url: "service-types");
      if (response.statusCode != 200) {
        return;
      }
      final data = jsonDecode(response.body);
      services.value = List<Map<String, dynamic>>.from(data["data"]);
    } catch (e) {
      print(e);
    } finally {
      loadingServices.value = false;
    }
  }

  String getCurrentStatusText() {
    if (profileStatus.value == "incomplete") {
      return "الملف الشخصي غير مكتمل";
    }

    if (profileStatus.value == "pending_review") {
      return "الملف الشخصي قيد المراجعة";
    }

    if (profileStatus.value == "rejected") {
      return "تم رفض الملف الشخصي";
    }

    return _statusText(currentApplicationStatus.value);
  }

  String _statusText(String status) {
    switch (status) {
      case "draft":
        return "بانتظار رفع الوثائق";

      case "documents_under_review":
        return "الوثائق قيد المراجعة";

      case "documents_rejected":
        return "تم رفض بعض الوثائق";

      case "payment_pending":
        return "بانتظار دفع الرسوم";

      case "appointment_pending":
        return "بانتظار حجز موعد";

      case "in_testing":
        return "قيد الاختبارات";

      case "waiting_retest":
        return "بانتظار إعادة الاختبار";

      case "approved":
        return "تمت الموافقة";

      default:
        return "-";
    }
  }

  Future<void> getProfileStatus() async {
    try {
      final response = await HttpHelper.gettData(url: "profile/status");
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        profileStatus.value = data["data"]["profile_status"];
        profileRejectionReason.value =
            data["data"]["profile_rejection_reason"] ?? "";
      }
      print("NEW STATUS = ${profileStatus.value}");
    } catch (e) {
      print(e);
    }
  }
  Future<void> loadHome() async {
    loadingHome.value = true;

    await Future.wait([
      getProfileStatus(),
      getCurrentApplication(),
      getServices(),
    ]);

    loadingHome.value = false;
  }
}
