import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

void copyToClipboard(String value) {
  Clipboard.setData(ClipboardData(text: value));
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.primary,
    colorText: Colors.white,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(16),
    borderRadius: 12,
    messageText: Text(
      'تم نسخ "$value"',
      textDirection: TextDirection.rtl,
      style: const TextStyle(color: Colors.white, fontSize: 13),
    ),
    titleText: const SizedBox.shrink(),
  );
}
