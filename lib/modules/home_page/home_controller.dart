import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/configuration/http_helpers.dart' show HttpHelper;
import '../create_application/create_application_step1.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool loadingOrder = false.obs;
  RxBool hasApplication = true.obs;
  RxInt applicationId = 0.obs;
  RxString currentApplicationNumber = "-".obs;
  RxString currentApplicationStatus = "-".obs;
  RxString currentService = "-".obs;
  RxString status = '-'.obs;
  RxBool loadingServices = false.obs;
  var isServicesExpanded = false.obs;
  RxList<Map<String, dynamic>> services = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var notificationsCount = 3.obs;
  @override
  void onInit() {
    super.onInit();
    getCurrentApplication();
    getServices();
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

  void openOrderDetails() {
    if (applicationId.value == 0) {
      return;
    }
    Get.toNamed("/order_details", arguments: applicationId.value);
  }

  void openUploadDocuments() {
    if (applicationId.value <= 0) {
      Get.snackbar("تنبيه", "لا يوجد طلب حالياً");
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
}
