import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';
import '../../services/notification_service.dart';
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
        emailError.value = email.isEmpty ? 'enter_email'.tr : '';
        passwordError.value = password.isEmpty ? 'enter_password'.tr : '';
        return;
      }
      if (!email.contains('@') || !email.contains('.')) {
        emailError.value =  'invalid_email'.tr;
        return;
      }
      final value = await HttpHelper.postData(
        url: 'auth/login',
        body: {'email': email, 'password': password},
      );
      print(value.body);
      //final res = LoginResponseModel.fromJson(jsonDecode(value.body));
      if (value.statusCode == 200 || value.statusCode == 201) {
        final res = LoginResponseModel.fromJson(jsonDecode(value.body));
        token = res.token;
        int role = res.roleId;
        int userId = res.userId;

        GetStorage box = GetStorage();
        box.write('token', token);
        box.write('id', role);
        box.write('user_id', userId);
        await NotificationService.initialize();
        print('LOGIN USER ID: $userId');
        print('STORED USER ID: ${box.read('user_id')}');
        print('LOGIN USER ID: ${res.userId}');
        AppSnackbar.show(
          'success'.tr,
          res.message,
        );
        Get.offNamed('/home');
      } else {
        final error = jsonDecode(value.body);
        AppSnackbar.show('login_failed'.tr, error['message']);
      }
    } catch (e) {
      AppSnackbar.show('exception'.tr,
        'error'.tr,);
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    print("SignInController onInit");
  }

  @override
  void onClose() {
    print("SignInController onClose");
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

}
