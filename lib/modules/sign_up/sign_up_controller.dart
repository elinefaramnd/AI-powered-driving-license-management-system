import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
      var response = await HttpHelper.postData(
        url: 'auth/register',
        body: data,
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      Map<String, dynamic> res = jsonDecode(response.body);
      print(jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetStorage box = GetStorage();
        box.write('name', name);
        AppSnackbar.show('تم انشاء الحساب بنجاح',
            res['message'].toString(),);
        Get.offNamed('/accountVerify', arguments: {'email': email});
      } else {
        print(jsonEncode(data));
        AppSnackbar.show('خطأ',
            res['message'].toString(),);
      }
    } catch (e) {
      print('Register Error: $e');
      AppSnackbar.show('خطأ',
          'An error occurred during the registration process',);
    } finally {
      isLoading.value = false;
    }
  }
}
