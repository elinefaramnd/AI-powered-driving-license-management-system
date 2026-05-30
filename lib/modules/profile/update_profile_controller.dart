import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configuration/http_helpers.dart';

class UpdateProfileController extends GetxController {
  final nameController = TextEditingController();
  final governorateController = TextEditingController();
  final addressController = TextEditingController();

  var isLoading = false.obs;

  List<String> provinces = [
    "دمشق",
    "ريف دمشق",
    "حلب",
    "حمص",
    "حماة",
    "اللاذقية",
    "طرطوس",
    "درعا",
    "السويداء",
    "القنيطرة",
    "دير الزور",
    "الرقة",
    "الحسكة",
  ];

  var selectedGovernorate = ''.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  late var user = Get.arguments;
  void loadData() {
    print(user);

    nameController.text = user["name"] ?? "";
    governorateController.text = user["governorate"] ?? "";
    addressController.text = user["address"] ?? "";
  }

  @override
  void onReady() {
    super.onReady();

    user = Get.arguments ?? {};

    nameController.text = user["name"] ?? "";

    governorateController.text = user["governorate"] ?? "";

    addressController.text = user["address"] ?? "";

    selectedGovernorate.value = user["governorate"] ?? "";
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final body = {
        "name": nameController.text,
        "governorate": governorateController.text,
        "address": addressController.text,
      };

      print(body);

      final response = await HttpHelper.putData(
        url: "profile/update",
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("نجاح", data["message"] ?? "تم التعديل بنجاح");
        Get.offAllNamed("/showPro");
      } else {
        Get.snackbar("خطأ", data["message"] ?? "فشل التعديل");
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
