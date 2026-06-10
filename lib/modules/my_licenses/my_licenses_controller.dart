import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      final response = await HttpHelper.gettData(
        url: "licenses",
      );

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
        return 'نشطة';
      case 'expired':
        return 'منتهية';
      case 'suspended':
        return 'موقوفة';
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
}
