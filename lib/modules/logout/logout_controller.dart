import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../configuration/http_helpers.dart';

class LogOutController extends GetxController {

  LogOutController();

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Are you sure to log out?',
      titleStyle: const TextStyle(fontSize: 18),
      content: const SizedBox.shrink(),
      cancelTextColor: AppColors.primaryColor,
      textConfirm: 'Confirm',
      buttonColor: AppColors.primaryColor,
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          final response = await HttpHelper.postData(
            url: 'auth/logout',
          );

          final res = jsonDecode(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            Get.back();
            Get.snackbar(
              'Signed out',
              res['data'] ?? 'Logout successful',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
            );
            Get.offAllNamed('/signIn');
          } else {
            Get.back();
            Get.snackbar(
              'Logout failed',
              res['message'] ?? 'An error occurred',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } catch (e) {
          Get.back();
          Get.snackbar(
            'Error',
            'Something went wrong',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
