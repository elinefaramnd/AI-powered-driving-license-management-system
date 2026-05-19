import 'dart:convert';

import 'package:get/get.dart';

import '../../configuration/http_helpers.dart';

class VerificationController extends GetxController {
  RxString otpCode = ''.obs;
  RxBool isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  void updateCode(String code) {
    otpCode.value = code;
  }

  void submitCode(String code) {
    otpCode.value = code;
    print("Code submitted: $code");
  }

  Future<void> verifyCodeAndProceed() async {
    if (otpCode.value.length != 6) {
      Get.snackbar("error", "Please enter a 6-digit code");
      return;
    }
    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        url: 'auth/verify-forgot-password-otp',
        body: {
          'email': email,
          'code': otpCode.value},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String resetToken =
        data['data']['reset_token'];

        Get.toNamed(
          '/resetPass',
          arguments: {
            'reset_token': resetToken,
            'email': Get.arguments['email'],
          },
        );
      } else {
        print(response.body);
        Get.snackbar("error", data['message'] ?? "كود غير صالح");
      }
    } catch (e) {
      Get.snackbar("خطأ", ": $e");
    } finally {
      isLoading.value = false;
    }
  }
}

