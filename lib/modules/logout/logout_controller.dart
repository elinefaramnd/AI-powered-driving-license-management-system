import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app_theme/app_colors.dart';
import '../../configuration/http_helpers.dart';
import '../chat_bot/chat_bot_controller.dart';

class LogOutController extends GetxController {
  LogOutController();
  final isLoading = false.obs;
  Future<void> logout() async {
    Get.defaultDialog(
      title: "logout_confirmation".tr,
      titleStyle: const TextStyle(fontSize: 18,
        fontWeight: FontWeight.bold,),
      titlePadding: const EdgeInsets.only(
        top: 30,

      ),
      content: const SizedBox(height: 5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      cancelTextColor: AppColors.primaryColor,
      textCancel: "cancel".tr,
      confirm: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Obx(
              () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: isLoading.value
                ? null
                : () async {
              isLoading.value = true;

              try {
                final box = GetStorage();
                final deviceId = box.read<String>('push_device_id');
                if (deviceId != null && deviceId.isNotEmpty) {
                  await deletePushToken(deviceId);
                }
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
                  if (Get.isRegistered<ChatController>()) {
                    Get.delete<ChatController>(force: true);
                  }
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
      ),
      onCancel: () {
        Get.back();
      },
    );
  }
  Future<void> deletePushToken(String deviceId) async {
    try {
      final response = await HttpHelper.deleteData(
        url: 'devices/push-token',
        body: {
          'device_id': deviceId,
        },
      );
      print('========== DELETE PUSH TOKEN ==========');
      print('device_id: $deviceId');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 204) {
        print('PUSH TOKEN DELETED SUCCESSFULLY');
      } else {
        print('FAILED TO DELETE PUSH TOKEN');
      }
    } catch (e) {
      print('DELETE PUSH TOKEN ERROR: $e');
    }
  }
}
