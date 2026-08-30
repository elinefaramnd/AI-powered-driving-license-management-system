part of 'chat_bot_controller.dart';

extension ChatControllerActions on ChatController {
  Future<void> confirmPendingAction() async {
    markAsInteracted();
    if (sessionId.value == null || actionId.value == null) {
      return;
    }
    messages.add(
      ChatMessage(text: 'تأكيد', isUser: true, timestamp: DateTime.now()),
    );
    isTyping.value = true;
    try {
      final data = await actionService.confirm(
        sessionId: sessionId.value!,
        actionId: actionId.value!,
      );
      if (data == null) return;
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty) {
        messages.add(
          ChatMessage(text: reply, isUser: false, timestamp: DateTime.now()),
        );
      }
      actionId.value = null;
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }
  Future<void> cancelPendingAction() async {
    markAsInteracted();
    if (sessionId.value == null || actionId.value == null) {
      return;
    }
    messages.add(
      ChatMessage(text: 'رفض', isUser: true, timestamp: DateTime.now()),
    );
    isTyping.value = true;
    try {
      final data = await actionService.cancel(
        sessionId: sessionId.value!,
        actionId: actionId.value!,
      );
      if (data == null) return;
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty) {
        messages.add(
          ChatMessage(text: reply, isUser: false, timestamp: DateTime.now()),
        );
      }
      actionId.value = null;
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }
  Future<void> acceptPrompt() async {
    await confirmPendingAction();
  }
  Future<void> rejectPrompt() async {
    await cancelPendingAction();
  }
}
