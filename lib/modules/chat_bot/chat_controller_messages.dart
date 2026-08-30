part of 'chat_bot_controller.dart';
extension ChatControllerMessages on ChatController {
  Future<void> sendMessageToBackend(String text) async {
    if (text.trim().isEmpty) return;
    markAsInteracted();
    messages.add(
      ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
    );
    isTyping.value = true;
    try {
      final data = await messageService.sendMessage(
        text: text,
        sessionId: sessionId.value,
      );
      if (data == null) return;
      final newSessionId = sessionService.updateSession(data);
      if (newSessionId != null) {
        sessionId.value = newSessionId;
      }
      final newActionId = sessionService.extractActionId(data);
      if (newActionId != null) {
        actionId.value = newActionId;
      }
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty) {
        messages.add(messageService.buildBotMessage(data));
      }
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
      selectedFile = null;
      selectedFileName.value = '';
    }
  }
}
