import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
import '../../services/notification_service.dart';
import '../../widgets/app_snackbar.dart';

class EmailVerificationController extends GetxController {
  RxString otpCode = ''.obs;
  RxBool isLoading = false.obs;
  late String email;
  String? token;
  @override
  void onInit() {
    super.onInit();

    final box = GetStorage();
    final arguments = Get.arguments;

    email = arguments?['email'] ??
        box.read<String>('pending_account_verification') ??
        '';
  }
  void updateCode(String code) {
    otpCode.value = code;
  }
  Future<void> verifyCodeAndProceed() async {
    if (otpCode.value.length != 6) {
      Get.snackbar(
        "error".tr,
        "enter_6_digit_code".tr,
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
        box.remove('pending_account_verification');
        await NotificationService.initialize();
        AppSnackbar.show("success".tr, data['message']);
        Get.offNamed('/completePro');
      } else {
        AppSnackbar.show( "error".tr, data['message']?? "invalid_verification_code".tr,);
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "error".tr,
        "unexpected_error".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
