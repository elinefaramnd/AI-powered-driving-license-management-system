import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configuration/http_helpers.dart';

class ChatActionService {
  Future<Map<String, dynamic>?> confirm({
    required int sessionId,
    required int actionId,
  }) async {
    return _send(
      sessionId: sessionId,
      body: {
        'action': 'confirm_pending_action',
        'action_id': actionId.toString(),
      },
      logTitle: 'CONFIRM ACTION',
    );
  }
  Future<Map<String, dynamic>?> cancel({
    required int sessionId,
    required int actionId,
  }) async {
    return _send(
      sessionId: sessionId,
      body: {
        'action': 'cancel_pending_action',
        'action_id': actionId.toString(),
      },
      logTitle: 'CANCEL ACTION',
    );
  }
  Future<Map<String, dynamic>?> _send({
    required int sessionId,
    required Map<String, dynamic> body,
    required String logTitle,
  }) async {
    try {
      print('========== $logTitle ==========');
      print('sessionId: $sessionId');
      print('body: $body');
      final response = await HttpHelper.postData(
        url: 'ai-agent/sessions/$sessionId/interactions',
        body: body,
      );
      print('statusCode: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        Get.snackbar(
          'chatbot_error'.tr,
          'Server error: ${response.statusCode}',
          backgroundColor:
          Colors.red.withOpacity(0.9),
          colorText: Colors.white,
        );
        return null;
      }
      final responseData =
      jsonDecode(response.body)
      as Map<String, dynamic>;
      return responseData['data']
      as Map<String, dynamic>?;
    } catch (e) {
      Get.snackbar(
        'chatbot_error'.tr,
        e.toString(),
        backgroundColor:
        Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return null;
    }
  }
}