import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configuration/http_helpers.dart';
import '../chat_message.dart';

class ChatMessageService {
  Future<Map<String, dynamic>?> sendMessage({
    required String text,
    required int? sessionId,
  }) async {
    final Map<String, dynamic> body = {'message': text};
    if (sessionId != null) {
      body['session_id'] = sessionId.toString();
    }
    final response = await HttpHelper.postData(
      url: 'ai-agent/message',
      body: body,
    );
    print('AI AGENT RESPONSE');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode < 200 || response.statusCode >= 300) {
      Get.snackbar(
        'chatbot_error'.tr,
        'Server error: ${response.statusCode}',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return null;
    }
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData['data'] as Map<String, dynamic>?;
  }

  ChatMessage buildBotMessage(Map<String, dynamic> data) {
    final String reply = data['reply']?.toString() ?? '';

    List<Map<String, dynamic>> applications = [];
    List<Map<String, dynamic>> appointmentSlots = [];
    List<Map<String, dynamic>> documents = [];
    List<Map<String, dynamic>> documentButtons = [];

    final uiPayload = data['ui_payload'];

    if (uiPayload is Map<String, dynamic>) {
      final applicationsData = uiPayload['applications'];

      if (applicationsData is List) {
        applications = applicationsData
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
      final selectionType = uiPayload['selection_type'];

      if (selectionType == 'appointment_slot') {
        final slots = uiPayload['slots'];

        if (slots is List) {
          appointmentSlots = slots
              .whereType<Map>()
              .map((slot) => Map<String, dynamic>.from(slot))
              .toList();
        }
      }

      final documentsData = uiPayload['documents'];

      if (documentsData is List) {
        documents = documentsData
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }

      final buttonsData = uiPayload['buttons'];

      if (buttonsData is List) {
        documentButtons = buttonsData
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
    }

    return ChatMessage(
      text: reply,
      isUser: false,
      timestamp: DateTime.now(),
      showActionButtons: data['requires_confirmation'] == true,
      applications: applications,
      appointmentSlots: appointmentSlots,
      documents: documents,
      documentButtons: documentButtons,
    );
  }
}
