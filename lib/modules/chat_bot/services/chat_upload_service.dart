import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configuration/http_helpers.dart';

class ChatUploadService {
  Future<File?> pickFile({
    required String uploadToken,
    required List<String> allowedExtensions,
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: uploadToken.isNotEmpty ? FileType.custom : FileType.any,
        allowedExtensions:
            uploadToken.isNotEmpty && allowedExtensions.isNotEmpty
            ? allowedExtensions
            : ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      Get.snackbar(
        'chatbot_error'.tr,
        'chatbot_pick_file_failed'.trParams({'error': e.toString()}),
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    }

    return null;
  }

  Future<Map<String, dynamic>?> upload({
    required int sessionId,
    required String uploadToken,
    required File file,
  }) async {
    try {
      print('UPLOAD DOCUMENT');
      print('sessionId: $sessionId');
      print('uploadToken: $uploadToken');
      print('file: ${file.path}');

      final response = await HttpHelper.postMultipartData(
        url: 'ai-agent/sessions/$sessionId/documents',
        filePath: file.path,
        uploadToken: uploadToken,
      );

      print('UPLOAD DOCUMENT RESPONSE');
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
    } catch (e) {
      Get.snackbar(
        'chatbot_error'.tr,
        e.toString(),
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );

      return null;
    }
  }
}
