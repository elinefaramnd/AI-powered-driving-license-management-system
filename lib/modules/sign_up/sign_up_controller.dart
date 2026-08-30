import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/modules/sign_up/sign_up_response_model.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  RxString nameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxBool isLoading = false.obs;
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }
  signUp(BuildContext context) async {
    String? token;
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      nameError.value = name.isEmpty ? 'required'.tr: '';
      phoneError.value = phone.isEmpty ? 'required'.tr: '';
      emailError.value = email.isEmpty ? 'required'.tr: '';
      passwordError.value = password.isEmpty ? 'required'.tr : '';
      confirmPasswordError.value = confirmPassword.isEmpty ? 'required'.tr : '';
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      emailError.value = 'invalid_email'.tr;
      return;
    }
    if (password.length < 8) {
      passwordError.value = 'password_min_length'.tr;
      return;
    }
    if (password != confirmPassword) {
      confirmPasswordError.value = 'password_not_match'.tr;
      return;
    }
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    isLoading.value = true;
    try {
      var response = await HttpHelper.postData(
        url: 'auth/register',
        body: data,
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      final responseData = jsonDecode(response.body);
      print(jsonEncode(data));
      print(jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {

        final res = SignUpResponseModel.fromJson(jsonDecode(response.body));
        GetStorage box = GetStorage();
        box.write('name', name);
        box.write('pending_account_verification', email);
        AppSnackbar.show('',
          res.message,);
        Get.offNamed('/accountVerify', arguments: {'email': email});
      } else {
        final data = jsonDecode(response.body);

        String errorMessage = data['message'] ?? 'registration_error'.tr;
        if (responseData['errors'] != null) {
          final errors = responseData['errors'] as Map<String, dynamic>;

          errorMessage = errors.values
              .expand((e) => e is List ? e : [e])
              .join('\n');
        }

        AppSnackbar.show(
          'error'.tr,
          errorMessage,
        );

        AppSnackbar.show(
          'error'.tr,
          errorMessage,
        );
      }
    } catch (e) {
      print('Register Error: $e');
      AppSnackbar.show('error'.tr,
        'registration_error'.tr,);
    } finally {
      isLoading.value = false;
    }
  }
}
