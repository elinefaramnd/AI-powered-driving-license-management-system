import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app_theme/app_colors.dart';
import '../../configuration/http_helpers.dart';

class LogOutController extends GetxController {
  LogOutController();
  final isLoading = false.obs;
  Future<void> logout() async {
    Get.defaultDialog(
      title: "logout_confirmation".tr,
      titleStyle: const TextStyle(fontSize: 18),
      content: const SizedBox.shrink(),
      cancelTextColor: AppColors.primaryColor,
     // textConfirm: 'تأكيد',
      //buttonColor: AppColors.primaryColor,
      textCancel: "cancel".tr,
      //confirmTextColor: Colors.white,
      //   onConfirm: () async {
      //     try {
      //       final response = await HttpHelper.postData(url: 'auth/logout');
      //
      //       final res = jsonDecode(response.body);
      //
      //       Get.back();
      //
      //       if (response.statusCode == 200 || response.statusCode == 201) {
      //         AppSnackbar.show(
      //           'تم تسجيل الخروج',
      //           res['message'] ?? 'تم تسجيل الخروج بنجاح',
      //         );
      //         await Future.delayed(const Duration(milliseconds: 150));
      //         Get.offAllNamed('/signIn');
      //       } else {
      //         AppSnackbar.show(
      //           'فشل تسجيل الخروج',
      //           res['message'] ?? 'حدث خطأ غير متوقع',
      //         );
      //       }
      //     } catch (e) {
      //       Get.back();
      //       AppSnackbar.show('خطأ', 'حدث خطأ أثناء العملية');
      //     }
      //   },
      confirm: Obx(
            () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
          onPressed: isLoading.value
              ? null
              : () async {
            isLoading.value = true;

            try {
              final response =
              await HttpHelper.postData(url: 'auth/logout');

              final res = jsonDecode(response.body);

              Get.back();

              if (response.statusCode == 200 ||
                  response.statusCode == 201) {
                AppSnackbar.show(
                  "logged_out".tr,
                  res['message'] ??  "logout_successfully".tr,
                );

                await Future.delayed(
                    const Duration(milliseconds: 150));

                Get.offAllNamed('/signIn');
              } else {
                AppSnackbar.show(
                  "logout_failed".tr,
                  res['message'] ?? "unexpected_error".tr,
                );
              }
            } catch (e) {
              Get.back();
              AppSnackbar.show(
                "error".tr,
                "operation_failed".tr,);
            } finally {
              isLoading.value = false;
            }
          },
          child: isLoading.value
              ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Text(
            "confirm".tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onCancel: () {
        Get.back();
      },
    );
  }
}
