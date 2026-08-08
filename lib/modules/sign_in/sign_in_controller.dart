import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';

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
  Future<void> signIn(BuildContext context) async {
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
      print('[DEBUG] Login status: ${value.statusCode}');
      print('[DEBUG] Login body: ${value.body}');
      Map<String, dynamic> res = jsonDecode(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']?['token'];
        if (token == null || token.toString().isEmpty) {
          AppSnackbar.show('خطأ', 'لم يتم استلام token من السيرفر');
          return;
        }
        final userData = res['data']?['user'];
        int role = 0;
        if (userData != null && userData['role'] is Map) {
          role = userData['role']['id'] ?? 0;
        } else if (userData != null && userData['role_id'] != null) {
          role = userData['role_id'] is int
              ? userData['role_id']
              : int.tryParse(userData['role_id'].toString()) ?? 0;
        }
        GetStorage box = GetStorage();
        box.write('token', token);
        box.write('id', role);
        if (userData != null && userData['id'] != null) {
          box.write('user_id', userData['id']);
        }
        Get.snackbar(
          'تم تسجيل الدخول بنجاح',
          '',
          messageText: Text(res['message'].toString()),
        );
        Get.offNamed('/home');
      } else {
        AppSnackbar.show('فشل تسجيل الدخول', res['message'].toString());
      }
    } catch (e, stackTrace) {
      print('[ERROR] Login exception: $e');
      print('[ERROR] Stack trace: $stackTrace');
      AppSnackbar.show('Exception', 'حدث خطأ: $e');
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
