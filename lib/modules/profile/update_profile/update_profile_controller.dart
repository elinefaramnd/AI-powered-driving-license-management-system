import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/profile/update_profile/update_profile_model.dart';
import 'package:project_2/widgets/app_snackbar.dart';

import '../../../configuration/http_helpers.dart';
import '../profile/profile_controller.dart';


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
  late final Map<String, dynamic> user;
  @override
  void onInit() {
    user = Get.arguments ?? {};
    loadData();
    super.onInit();
  }

  void loadData() {
    print(user);

    nameController.text = user["name"] ?? "";
    governorateController.text = user["governorate"] ?? "";
    addressController.text = user["address"] ?? "";
  }

  @override
  void onReady() {
    super.onReady();


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
      final model = UpdateProfileModel.fromJson(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.show("نجاح", model.message);
        Get.offNamed("/showPro");
      } else {
        AppSnackbar.show("خطأ", model.message);
      }
    } catch (e) {
      AppSnackbar.show("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
