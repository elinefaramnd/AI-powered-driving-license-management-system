import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../configuration/http_helpers.dart';

class CompleteProfileController extends GetxController{
  final nameController = TextEditingController();
  final nationalNumController = TextEditingController();
  final birthDateController = TextEditingController();
  final governorateController = TextEditingController();
  final addressController = TextEditingController();
  var selectedGovernorate = ''.obs;
  var isLoading = false.obs;
  RxString nameError = ''.obs;
  RxString nationalIdError = ''.obs;
  RxString birthDateError = ''.obs;
  RxString governorateError = ''.obs;
  RxString addressError = ''.obs;
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
  Future<void> completeProfile() async {
    if (nameController.text.trim().isEmpty) {
      nameError.value = 'يرجى إدخال الاسم الكامل';
    }

    if (nationalNumController.text.trim().isEmpty) {
      nationalIdError.value = 'يرجى إدخال الرقم الوطني';
    }
    else if (nationalNumController.text.trim().length != 11) {
      nationalIdError.value = 'الرقم الوطني يجب أن يكون 11 خانة';
    }

    if (birthDateController.text.trim().isEmpty) {
      birthDateError.value = 'يرجى اختيار تاريخ الميلاد';
    }

    if (governorateController.text.trim().isEmpty) {
      governorateError.value = 'يرجى اختيار المحافظة';
    }

    if (addressController.text.trim().isEmpty) {
      addressError.value = 'يرجى إدخال العنوان';
    }

    if (
    nameError.value.isNotEmpty ||
        nationalIdError.value.isNotEmpty ||
        birthDateError.value.isNotEmpty ||
        governorateError.value.isNotEmpty ||
        addressError.value.isNotEmpty
    ) {
      return;
    }
    try {
      isLoading.value = true;

      final body = {
        "name": nameController.text,
        "national_id": nationalNumController.text,
        "birth_date": birthDateController.text, // لاحقاً نحوله ISO
        "governorate": governorateController.text,
        "address": addressController.text,
      };
      print(body);
      final response = await HttpHelper.putData(
        url: "profile/complete",
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", data["message"] ?? "Done",
          backgroundColor: AppColors.primaryColor.withOpacity(0.8),
            margin:  EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ));
        Get.offNamed('/home');
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed",
            backgroundColor: Colors.red.withOpacity(0.8),
            margin:  EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ));
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
