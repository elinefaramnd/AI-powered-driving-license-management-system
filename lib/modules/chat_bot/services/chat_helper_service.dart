import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHelperService {
  bool checkSession({
    required int? sessionId,
    required String selectionToken,
  }) {
    if (sessionId == null) {
      print('No session ID');
      return false;
    }
    if (selectionToken.isEmpty) {
      print('No selection token');
      return false;
    }
    return true;
  }
  void showError(
      dynamic error,
      ) {
    print('Chat Error: $error');
    final errorText = error.toString().toLowerCase();
    if (errorText.contains('invalid argument') ||
        errorText.contains('invalid_argument') ||
        errorText.contains('no upload token') ||
        errorText.contains('no selection token') ||
        errorText.contains('no session id')) {
      return;
    }
    Get.snackbar(
      'chatbot_error'.tr,
      error.toString(),
      backgroundColor:
      Colors.red.withOpacity(0.9),
      colorText: Colors.white,
    );
  }
}