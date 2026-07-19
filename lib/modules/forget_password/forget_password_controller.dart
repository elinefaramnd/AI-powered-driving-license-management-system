import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';
import 'forget_password_model.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendForgetRequest() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      AppSnackbar.show("error".tr, "enter_email_error".tr);
      return;
    }

    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        url: "auth/forgot-password",
        body: {"email": email},
      );
      final data = jsonDecode(response.body);
      final model = ForgetPasswordModel.fromJson(data);
      if (response.statusCode == 200) {
        Get.toNamed(
          '/emailVerify',
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        print(response.body);
        print(response.statusCode);
        AppSnackbar.show("error".tr, model.message);
      }
    } catch (e) {
      AppSnackbar.show("error".tr, ":$e");
    } finally {
      isLoading.value = false;
    }
  }
}
