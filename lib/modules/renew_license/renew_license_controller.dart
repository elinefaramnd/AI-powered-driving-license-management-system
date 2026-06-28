import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
import '../../modules/my_licenses/license_model.dart';
import '../../widgets/app_snackbar.dart';

class RenewLicenseController extends GetxController {
  RxBool loading = false.obs;
  RxBool creatingRenewal = false.obs;
  RxList<LicenseModel> licenses = <LicenseModel>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getLicenses();
  }

  Future<void> getLicenses() async {
    try {
      loading.value = true;
      final response = await HttpHelper.gettData(url: "licenses");
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        final List items = data["data"];
        licenses.value = items.map((e) => LicenseModel.fromJson(e)).toList();
      } else {
        AppSnackbar.show("خطأ", data["message"] ?? "فشل تحميل الرخص");
      }
    } catch (e) {
      AppSnackbar.show("خطأ", "فشل تحميل الرخص");
    } finally {
      loading.value = false;
    }
  }

  List<LicenseModel> get renewableLicenses {
    return licenses.where((l) => l.status == 'active' || l.status == 'expired').toList();
  }

  bool isRenewable(LicenseModel license) {
    return license.status == 'active' || license.status == 'expired';
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'نشطة';
      case 'expired':
        return 'منتهية';
      case 'suspended':
        return 'موقوفة';
      case 'renewed':
        return 'مجددة';
      default:
        return status;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'suspended':
        return Colors.orange;
      case 'renewed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Future<void> createRenewal(LicenseModel license) async {
    if (!isRenewable(license)) {
      AppSnackbar.show("تنبيه", "لا يمكن تجديد هذه الرخصة");
      return;
    }

    try {
      creatingRenewal.value = true;
      final response = await HttpHelper.postData(
        url: "applications",
        body: {
          "service_type_code": "renew_license",
          "related_license_id": license.id.toString(),
        },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final int applicationId = data["data"]["id"];
        box.write("application_id", applicationId);
        AppSnackbar.show("نجاح", "تم إنشاء طلب التجديد بنجاح");
        Get.toNamed(
          "/upload_documents",
          arguments: {
            "applicationId": applicationId,
            "flow": "renewal",
          },
        );
      } else {
        AppSnackbar.show("خطأ", data["message"] ?? "فشل إنشاء طلب التجديد");
      }
    } catch (e) {
      AppSnackbar.show("خطأ", "فشل إنشاء طلب التجديد: $e");
    } finally {
      creatingRenewal.value = false;
    }
  }
}
