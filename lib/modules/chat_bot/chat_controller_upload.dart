part of 'chat_bot_controller.dart';

extension ChatControllerUpload on ChatController {
  Future<void> pickFile() async {
    if (uploadToken.value.isEmpty) {
      return;
    }

    final file = await uploadService.pickFile(
      uploadToken: uploadToken.value,
      allowedExtensions: allowedExtensions.toList(),
    );

    if (file == null) return;

    selectedFile = file;

    selectedFileName.value = file.path.split(Platform.pathSeparator).last;

    isTyping.value = false;

    print('Selected file: ${file.path}');
  }

  void clearSelectedFile() {
    selectedFile = null;
    selectedFileName.value = '';
  }

  Future<void> uploadRequiredDocument() async {
    markAsInteracted();
    if (sessionId.value == null ||
        uploadToken.value.isEmpty ||
        selectedFile == null) {
      return;
    }
    isTyping.value = true;
    try {
      final data = await uploadService.upload(
        sessionId: sessionId.value!,
        uploadToken: uploadToken.value,
        file: selectedFile!,
      );
      if (data == null) return;
      final newSessionId = sessionService.updateSession(data);
      if (newSessionId != null) {
        sessionId.value = newSessionId;
      }
      final reply = data['reply']?.toString() ?? '';
      List<Map<String, dynamic>> remainingDocuments = [];
      final uiPayload = data['ui_payload'];
      if (uiPayload is Map<String, dynamic>) {
        remainingDocuments = selectionService.extractList(
          uiPayload['remaining_documents'],
        );
      }
      if (reply.isNotEmpty) {
        messages.add(
          ChatMessage(
            text: reply,
            isUser: false,
            timestamp: DateTime.now(),
            documents: remainingDocuments,
          ),
        );
      }
      selectedFile = null;
      selectedFileName.value = '';
      uploadToken.value = '';
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }
}
