import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
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


    if (name.isEmpty || phone.isEmpty ||email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      nameError.value = name.isEmpty ? 'مطلوب' : '';
      phoneError.value = phone.isEmpty ? 'مطلوب' : '';
      emailError.value = email.isEmpty ? 'مطلوب' : '';
      passwordError.value = password.isEmpty ? 'مطلوب' : '';
      confirmPasswordError.value = confirmPassword.isEmpty ? 'مطلوب' : '';
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      emailError.value = 'بريد إلكتروني غير صالح';
      return;
    }
    if (password.length < 8) {
      passwordError.value = 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
      return;
    }
    if (password != confirmPassword) {
      confirmPasswordError.value = 'كلمة المرور غير متطابقة';
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
      var response = await HttpHelper.postData(url: 'auth/register', body: data);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      Map<String, dynamic> res = jsonDecode(response.body);
      print(jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('تم انشاء الحساب بنجاح', res['message'].toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),);
        Get.offNamed(
          '/accountVerify',
          arguments: {
            'email': email,
          },
        );
      } else {
        print(jsonEncode(data));
        Get.snackbar('خطأ', res['message'].toString(),
          backgroundColor:  Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),);
      }
    } catch (e) {
      print('Register Error: $e');
      Get.snackbar('Exception', 'An error occurred during the registration process',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),);
    }
    finally {
      isLoading.value = false;
    }
  }
}