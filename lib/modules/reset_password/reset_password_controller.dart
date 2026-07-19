import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/reset_password/reset_password_model.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';
import '../sign_in/sign_in_screen.dart';

class ResetPasswordController extends GetxController {
  late String resetToken;
  final String email = Get.arguments['email'];
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> reset() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar( "error".tr,
        "fill_all_fields".tr,);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("error".tr,
        "password_not_match".tr,);
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
          "password_confirmation": confirmPassword,
        },
      );
      final model = ResetPasswordModel.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        AppSnackbar.show( "success".tr, model.message);
        Get.toNamed('/signIn');
      } else {
        print(response.body);
        AppSnackbar.show("error".tr, model.message);
      }
    } catch (e) {
      Get.snackbar("error".tr, "${"server_error".tr}:$e");
    } finally {
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
