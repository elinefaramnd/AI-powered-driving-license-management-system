import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
class ApplicationController extends GetxController {
  RxList services = [].obs;
  RxList licenses = [].obs;
  RxInt serviceTypeId = 0.obs;
  RxInt licenseTypeId = 0.obs;
  RxInt applicationId = 0.obs;
  RxBool loading = false.obs;
  RxBool pageLoading = true.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  Future<void> loadData() async {
    try {
      pageLoading.value = true;
      await Future.wait([getServices(), getLicenses()]);
    } finally {
      pageLoading.value = false;
    }
  }
  Future<void> getServices() async {
    final response = await HttpHelper.gettData(url: "service-types");
    final data = jsonDecode(response.body);
    services.value = data["data"];
  }
  Future<void> getLicenses() async {
    final response = await HttpHelper.gettData(url: "license-types");
    final data = jsonDecode(response.body);
    licenses.value = data["data"];
  }
  Future<void> createDraft() async {
    try {
      if (serviceTypeId.value == 0) {
        Get.snackbar("تنبيه", "اختر نوع الخدمة");
        return;
      }
      if (licenseTypeId.value == 0) {
        Get.snackbar("تنبيه", "اختر نوع الرخصة");
        return;
      }
      loading.value = true;
      final response = await HttpHelper.postData(
        url: "applications",
        body: {
          "service_type_id": serviceTypeId.value.toString(),
          "license_type_id": licenseTypeId.value.toString(),
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final id = data["data"]["id"];
        applicationId.value = id;
        box.write("application_id", id);
        print("CREATED ID => $id");
        Get.toNamed("/upload_documents", arguments: id);
      } else {
        Get.snackbar("خطأ", data["message"]);
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      loading.value = false;
    }
  }
}
