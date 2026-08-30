import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
import '../../widgets/app_snackbar.dart';

class ApplicationController extends GetxController {
  RxList services = [].obs;
  RxList licenses = [].obs;
  RxInt serviceTypeId = 0.obs;
  RxInt licenseTypeId = 0.obs;
  RxInt applicationId = 0.obs;
  RxBool loading = false.obs;
  RxBool pageLoading = true.obs;
  RxList ownedLicenses = [].obs;
  RxInt relatedLicenseId = 0.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    final licenseId = Get.arguments as int?;

    loadData().then((_) {
      if (licenseId != null) {
        prepareUnblock(licenseId);
      }
    });
  }

  Future<void> loadData() async {
    try {
      pageLoading.value = true;
      await Future.wait([getServices(), getLicenses(), getOwnedLicenses()]);
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
        AppSnackbar.show("warning".tr, "select_service_type".tr);
        return;
      }

      final service = services.firstWhere(
        (e) => e["id"] == serviceTypeId.value,
      );

      final serviceCode = service["code"];
      if (serviceCode == "new_license") {
        if (licenseTypeId.value == 0) {
          AppSnackbar.show("warning".tr, "select_license_type".tr);
          return;
        }
      } else if (serviceCode == "renew_license" ||
          serviceCode == "lost_replacement" ||
          serviceCode == "damaged_replacement" ||
          serviceCode == "license_unblock") {
        if (relatedLicenseId.value == 0) {
          AppSnackbar.show("warning".tr, "select_license".tr);
          return;
        }
      }

      loading.value = true;
      Map<String, dynamic> body;

      if (serviceCode == "new_license") {
        final selectedLicenseType = licenses.firstWhere(
          (e) => e["id"] == licenseTypeId.value,
        );

        body = {
          "service_type_code": serviceCode,
          "license_type_code": selectedLicenseType["code"],
        };
      } else {
        body = {
          "service_type_code": serviceCode,
          "related_license_id": relatedLicenseId.value.toString(),
        };
      }

      final response = await HttpHelper.postData(
        url: "applications",
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final id = data["data"]["id"];

        applicationId.value = id;
        box.write("application_id", id);

        print("CREATED ID => $id");

        Get.toNamed("/upload_documents", arguments: id);
      } else {
        AppSnackbar.show("error".tr, data["message"]);
      }
    } catch (e) {
      Get.snackbar("error".tr, e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> getOwnedLicenses() async {
    final response = await HttpHelper.gettData(url: "licenses");
    final data = jsonDecode(response.body);
    ownedLicenses.value = data["data"];
  }
  Future<void> prepareUnblock(int licenseId) async {
    if (services.isEmpty) {
      await loadData();
    }

    final service = services.firstWhere(
          (e) => e["code"] == "license_unblock",
    );

    serviceTypeId.value = service["id"];
    relatedLicenseId.value = licenseId;
  }
}
