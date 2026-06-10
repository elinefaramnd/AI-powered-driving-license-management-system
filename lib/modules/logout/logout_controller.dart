import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app_theme/app_colors.dart';
import '../../configuration/http_helpers.dart';

class LogOutController extends GetxController {
  LogOutController();

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'تأكيد تسجيل الخروج',
      titleStyle: const TextStyle(fontSize: 18),
      content: const SizedBox.shrink(),
      cancelTextColor: AppColors.primaryColor,
      textConfirm: 'تأكيد',
      buttonColor: AppColors.primaryColor,
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          final response = await HttpHelper.postData(url: 'auth/logout');

          final res = jsonDecode(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            Get.back();
            AppSnackbar.show('تم تسجيل الخروج', res['message'] ?? 'تم تسجيل الخروج بنجاح',);
            Get.offAllNamed('/signIn');
          } else {
            Get.back();
            AppSnackbar.show('فشل تسجيل الخروج',
              res['message'] ?? 'حدث خطأ غير متوقع',);
          }
        } catch (e) {
          Get.back();
          AppSnackbar.show('خطأ',
            'حدث خطأ أثناء العملية',);
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
