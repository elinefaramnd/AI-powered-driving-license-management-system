import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/chat_bot/chat_bot_screen.dart';

import '../../app_theme/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool hasAttachment;
  final String? attachmentName;
  final File? attachmentFile;
  final bool showActionButtons;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.hasAttachment = false,
    this.attachmentName,
    this.attachmentFile,
    this.showActionButtons = false,
  });
}

class ChatController extends GetxController {
  RxBool showMessage = true.obs;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxString selectedFileName = ''.obs;
  File? selectedFile;

  @override
  void onInit() {
    super.onInit();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    messages.add(ChatMessage(
      text: 'مرحبا! أنا المساعد الذكي الخاص بتطبيق سيرتك..\nكيف يمكنني مساعدتك؟',
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  // TODO: Load messages from backend
  Future<void> loadMessages() async {
    // Call your API here
    // messages.assignAll(await ApiService.getChatMessages());
  }

  // TODO: Send message to backend
  Future<void> sendMessageToBackend(String text) async {
    if (text.isEmpty && selectedFileName.value.isEmpty) return;

    // Add user message locally
    messages.add(ChatMessage(
      text: text.isNotEmpty ? text : 'تم إرفاق ملف',
      isUser: true,
      timestamp: DateTime.now(),
      hasAttachment: selectedFileName.value.isNotEmpty,
      attachmentName: selectedFileName.value.isNotEmpty ? selectedFileName.value : null,
      attachmentFile: selectedFile,
    ));

    // TODO: Upload file to backend
    // if (selectedFile != null) {
    //   await ApiService.uploadFile(selectedFile!);
    // }

    // Clear selected file after sending
    selectedFile = null;
    selectedFileName.value = '';

    // TODO: Call API to send message
    // await ApiService.sendMessage(text, attachment);
  }

  void close() {
    print("CLOSE CLICKED");
    showMessage.value = false;
  }

  void openChatScreen() {
    Get.to(() => ChatBotScreen());
  }

  // Called when backend sends a new message
  void onNewMessageFromBackend(Map<String, dynamic> messageData) {
    messages.add(ChatMessage(
      text: messageData['text'] ?? '',
      isUser: false,
      timestamp: DateTime.parse(messageData['timestamp'] ?? DateTime.now().toIso8601String()),
      showActionButtons: messageData['show_actions'] ?? false,
    ));
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedFile = File(result.files.single.path!);
        selectedFileName.value = result.files.single.name;

        Get.snackbar(
          'تم اختيار الملف',
          result.files.single.name,
          backgroundColor: AppColors.gold.withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في اختيار الملف: $e',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    }
  }

  void clearSelectedFile() {
    selectedFile = null;
    selectedFileName.value = '';
  }

  // TODO: Send accept action to backend
  void acceptPrompt() {
    // await ApiService.sendAction('accept');
    Get.snackbar(
      'تم القبول',
      'تم قبول طلبك بنجاح',
      backgroundColor: AppColors.primary.withOpacity(0.9),
      colorText: Colors.white,
    );
  }

  // TODO: Send reject action to backend
  void rejectPrompt() {
    // await ApiService.sendAction('reject');
    Get.snackbar(
      'تم الرفض',
      'تم رفض الطلب',
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
    );
  }
}

