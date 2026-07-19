import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/widgets/app_snackbar.dart';

import '../../../app/controllers/app_update_controller.dart';
import '../../../configuration/http_helpers.dart';
import '../../home_page/home_controller.dart';
import 'complete_profile_model.dart';


class CompleteProfileController extends GetxController {
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
    print("completeProfile called");
    nameError.value = '';
    nationalIdError.value = '';
    birthDateError.value = '';
    governorateError.value = '';
    addressError.value = '';
    if (nameController.text.trim().isEmpty) {
      nameError.value =  'enter_full_name'.tr;
    }
    if (nationalNumController.text.trim().isEmpty) {
      nationalIdError.value = 'enter_national_id'.tr;
    } else if (nationalNumController.text.trim().length != 11) {
      nationalIdError.value = 'national_id_length'.tr;
    }
    if (birthDateController.text.trim().isEmpty) {
      birthDateError.value ='select_birth_date'.tr;
    }
    if (governorateController.text.trim().isEmpty) {
      governorateError.value = 'select_governorate_error'.tr;
    }
    if (addressController.text.trim().isEmpty) {
      addressError.value = 'enter_address_error'.tr;
    }
    print("nameError = ${nameError.value}");
    print("nationalIdError = ${nationalIdError.value}");
    print("birthDateError = ${birthDateError.value}");
    print("governorateError = ${governorateError.value}");
    print("addressError = ${addressError.value}");
    if (nameError.value.isNotEmpty ||
        nationalIdError.value.isNotEmpty ||
        birthDateError.value.isNotEmpty ||
        governorateError.value.isNotEmpty ||
        addressError.value.isNotEmpty) {
      return;
    }
    try {
      isLoading.value = true;
      final body = {
        "name": nameController.text,
        "national_id": nationalNumController.text,
        "birth_date": birthDateController.text,
        "governorate": governorateController.text,
        "address": addressController.text,
      };
      print(body);
      final response = await HttpHelper.putData(
        url: "profile/complete",
        body: body,
      );
      print(response.statusCode);
      print(response.body);
      final data = jsonDecode(response.body);
      final model = CompleteProfileModel.fromJson(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.show('نجاح', model.message ,);
        if (Get.isRegistered<HomeController>()) {
          final home = Get.find<HomeController>();

          await Future.wait([
            home.getProfileStatus(),
            home.getCurrentApplication(),
            home.getServices(),
          ]);
        }

        Get.offAllNamed('/home');

      } else {
        AppSnackbar.show("error".tr,
          model.message );
      }
    } catch (e) {
      AppSnackbar.show("error".tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  String? validateName() {
    final storedName = (GetStorage().read('name') ?? '').toString().trim();
    final enteredName = nameController.text.trim();

    print("storedName = '$storedName'");
    print("enteredName = '$enteredName'");
    print(storedName.length);
    print(enteredName.length);

    if (storedName != enteredName) {
      return "name_not_match_register".tr;
    }

    return null;
  }
}
