import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
import '../../modules/my_licenses/license_model.dart';
import '../../widgets/app_snackbar.dart';

class LostReplacementController extends GetxController {
  RxBool loading = false.obs;
  RxBool creating = false.obs;
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

  bool isEligible(LicenseModel license) {
    return license.status == 'active';
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'نشطة';
      case 'expired':
        return 'منتهية';
      case 'suspended':
        return 'موقوفة';
      case 'inactive':
        return 'غير نشطة';
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
      case 'inactive':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Future<void> createLostReplacement(LicenseModel license) async {
    if (!isEligible(license)) {
      AppSnackbar.show("تنبيه", "الرخصة غير مؤهلة لإصدار بدل فاقد");
      return;
    }

    try {
      creating.value = true;
      final response = await HttpHelper.postData(
        url: "applications",
        body: {
          "service_type_code": "lost_replacement",
          "related_license_id": license.id.toString(),
        },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final int applicationId = data["data"]["id"];
        box.write("application_id", applicationId);
        AppSnackbar.show("نجاح", "تم إنشاء طلب بدل فاقد بنجاح");
        Get.toNamed(
          "/upload_documents",
          arguments: {
            "applicationId": applicationId,
            "flow": "lost_replacement",
          },
        );
      } else {
        AppSnackbar.show("خطأ", data["message"] ?? "فشل إنشاء طلب بدل فاقد");
      }
    } catch (e) {
      AppSnackbar.show("خطأ", "فشل إنشاء طلب بدل فاقد: $e");
    } finally {
      creating.value = false;
    }
  }
}
