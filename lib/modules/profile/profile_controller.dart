import 'dart:convert';

import 'package:get/get.dart';

import '../../configuration/http_helpers.dart';

class ProfileController extends GetxController {

  var isLoading = false.obs;

  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {

    try {

      isLoading.value = true;

      final response = await HttpHelper.gettData(
        url: "auth/me",
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        userData.value = data["data"];

      } else {

        Get.snackbar(
          "خطأ",
          data["message"] ?? "فشل",
        );
      }

    } catch (e) {

      Get.snackbar(
        "خطأ",
        e.toString(),
      );

    } finally {

      isLoading.value = false;
    }
  }
}