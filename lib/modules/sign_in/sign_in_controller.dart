import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';
import 'login_response_model.dart';

class SignInController extends GetxController {
  String? token;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxBool isLoading = false.obs;
  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
  signIn(BuildContext context) async {
    isLoading.value = true;
    try {
      String email = emailController.text.trim();
      String password = passwordController.text;
      if (email.isEmpty || password.isEmpty) {
        emailError.value = email.isEmpty ? 'يرجى إدخال البريد الإلكتروني' : '';
        passwordError.value = password.isEmpty ? 'يرجى إدخال كلمة المرور' : '';
        return;
      }
      if (!email.contains('@') || !email.contains('.')) {
        emailError.value = 'بريد إلكتروني غير صالح';
        return;
      }
      final value = await HttpHelper.postData(
        url: 'auth/login',
        body: {'email': email, 'password': password},
      );
      final res = LoginResponseModel.fromJson(jsonDecode(value.body));
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res.token;
        int role = res.roleId;
        GetStorage box = GetStorage();
        box.write('token', token);
        box.write('id', role);
        AppSnackbar.show(
          'نجاح',
          res.message,
        );
        Get.offNamed('/home');
      } else {
        AppSnackbar.show('فشل تسجيل الدخول', res.message);
      }
    } catch (e) {
      AppSnackbar.show('Exception', 'حدث خطأ');
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
