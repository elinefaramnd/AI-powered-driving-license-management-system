import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configuration/http_helpers.dart';

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
      Get.snackbar("خطأ", "يرجى إدخال البريد الإلكتروني");
      return;
    }

    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        url: "auth/forgot-password",
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        Get.toNamed(
          '/emailVerify',
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        final data = jsonDecode(response.body);
        print(response.body);
        print(response.statusCode);
        Get.snackbar("error", data['message'] ?? 'حدث خطأ');
      }
    } catch (e) {
      Get.snackbar("error", ":$e");
    } finally {
      isLoading.value = false;
    }
  }
}
