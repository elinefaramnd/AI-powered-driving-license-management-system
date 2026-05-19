import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import '../sign_in/sign_in_screen.dart';
class ResetPasswordController extends GetxController {
  late String resetToken;
  final String email = Get.arguments['email'];
  final passwordController =
  TextEditingController();
  final confirmPasswordController =
  TextEditingController();
  RxBool obscurePassword = true.obs;

  RxBool obscureConfirmPassword = true.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    print(Get.arguments);
    resetToken = Get.arguments['reset_token'];
  }
  void togglePassword() {

    obscurePassword.value =
    !obscurePassword.value;
  }

  void toggleConfirmPassword() {

    obscureConfirmPassword.value =
    !obscureConfirmPassword.value;
  }
  Future<void> reset() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("خطأ", "الرجاء ملىء جميع الحقول");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("خطأ", "كلمة المرور غير متطابقة");
      return;
    }
    isLoading.value = true;
    try {
      final response = await HttpHelper.postData(
        url: "auth/reset-password",
        body: {
          "email": email,
          "reset_token": resetToken,
          "password": password,
          "password_confirmation": confirmPassword
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", data['message']);
        Get.to(() => SignInScreen());


      } else {
        print(response.body);
        Get.snackbar("Error", data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "Server error: $e");
    }finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}