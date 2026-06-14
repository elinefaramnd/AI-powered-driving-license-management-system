import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import '../../app_theme/app_colors.dart';

class SendMessageController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingProfile = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      isLoadingProfile.value = true;
      final response = await HttpHelper.gettData(url: 'auth/me');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = data['data'] ?? {};
        nameController.text = user['name'] ?? '';
        emailController.text = user['email'] ?? '';
        phoneController.text = user['phone'] ?? '';
      }
    } catch (_) {
    } finally {
      isLoadingProfile.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  bool _validate() {
    if (nameController.text.trim().isEmpty) {
      _showError('الرجاء إدخال الاسم');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      _showError('الرجاء إدخال البريد الإلكتروني');
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError('الرجاء إدخال رقم الهاتف');
      return false;
    }
    if (subjectController.text.trim().isEmpty) {
      _showError('الرجاء إدخال الموضوع');
      return false;
    }
    if (messageController.text.trim().isEmpty) {
      _showError('الرجاء إدخال نص الرسالة');
      return false;
    }
    return true;
  }

  void _showError(String msg) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      messageText: Text(
        msg,
        textDirection: TextDirection.rtl,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      titleText: const SizedBox.shrink(),
    );
  }

  Future<void> sendMessage() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      final response = await HttpHelper.postData(
        url: 'contact-messages',
        body: {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'subject': subjectController.text.trim(),
          'message': messageController.text.trim(),
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 300));
        Get.snackbar(
          '',
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          messageText: Text(
            data['message'] ?? 'تم إرسال رسالتك بنجاح',
            textDirection: TextDirection.rtl,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          titleText: const SizedBox.shrink(),
        );
      } else {
        _showError(data['message'] ?? 'فشل إرسال الرسالة');
      }
    } catch (e) {
      _showError('حدث خطأ أثناء الاتصال بالخادم');
    } finally {
      isLoading.value = false;
    }
  }
}
