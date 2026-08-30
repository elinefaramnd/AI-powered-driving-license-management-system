import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../configuration/http_helpers.dart';
import 'license_model.dart';

class MyLicensesController extends GetxController {
  RxBool loading = false.obs;
  RxList<LicenseModel> licenses = <LicenseModel>[].obs;
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
      if (data["success"] == true) {
        final List items = data["data"];
        licenses.value = items.map((e) => LicenseModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching licenses: $e');
    } finally {
      loading.value = false;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return "license_active".tr;
      case 'expired':
        return "license_expired".tr;
      case 'suspended':
        return "license_suspended".tr;
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
      default:
        return Colors.grey;
    }
  }

  Future<void> downloadLicense(int licenseId) async {
    try {
      loading.value = true;
      final box = GetStorage();
      final token = box.read<String>('token');
      final lang = box.read<String>('lang') ?? 'ar';
      final response = await http.post(
        Uri.parse(
          '${baseurl}licenses/$licenseId/download',
        ),
        headers: {
          'Accept': 'application/pdf',
          'Accept-Language': lang,
          'Authorization': 'Bearer $token',
        },
      );
      print("DOWNLOAD STATUS: ${response.statusCode}");
      print("CONTENT TYPE: ${response.headers['content-type']}");
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File(
          '${directory.path}/license_$licenseId.pdf',
        );
        await file.writeAsBytes(response.bodyBytes);
        print("PDF SAVED: ${file.path}");
        await OpenFilex.open(file.path);
      } else {
        print("DOWNLOAD ERROR: ${response.body}");
        Get.snackbar(
          "error".tr,
          "something_went_wrong".tr,
        );
      }
    } catch (e) {
      print("DOWNLOAD EXCEPTION: $e");
      Get.snackbar(
        "error".tr,
        e.toString(),
      );
    } finally {
      loading.value = false;
    }
  }
}
