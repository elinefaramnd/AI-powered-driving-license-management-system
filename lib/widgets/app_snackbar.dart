import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void show(
      String title,
      String message, {
        Color? backgroundColor,
        Color? colorText,
      }) {
    Get.snackbar(
      "",
      "",
      backgroundColor: backgroundColor,
      colorText: colorText,
      titleText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          title,
          textAlign: TextAlign.right,
        ),
      ),
      messageText: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          message,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}