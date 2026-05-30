import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';

class EmailVerificationController extends GetxController {
  RxString otpCode = ''.obs;
  RxBool isLoading = false.obs;
  late String email;
  String? token;
  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }
  void updateCode(String code) {
    otpCode.value = code;
  }
  Future<void> verifyCodeAndProceed() async {
    if (otpCode.value.length != 6) {
      Get.snackbar(
        "خطأ",
        "الرجاء إدخال الرمز المكزن من 6 أرقام",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;
    try {
      final response = await HttpHelper.postData(
        url: 'auth/verify-otp',
        body: {'email': email, 'code': otpCode.value},
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        token = data['data']['token'];
        int userId = data['data']['user']['id'];
        int roleId = data['data']['user']['role']['id'];
        GetStorage box = GetStorage();
        box.write('token', token);
        box.write('userId', userId);
        box.write('roleId', roleId);
        Get.snackbar(
          "نجاح",
          data['message'],
          colorText: Colors.black,
        );
        Get.offNamed('/completePro');
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Invalid code",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Exception",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
