part of 'chat_bot_controller.dart';

extension ChatControllerStorage on ChatController {
  void loadSavedChat() {
    final storedUserId = box.read('user_id');

    if (storedUserId == null) {
      _addWelcomeMessage();
      return;
    }
    final savedMessages = storage.loadMessages(storedUserId.toString());
    final savedSession = storage.loadSession(storedUserId.toString());
    if (savedMessages.isNotEmpty) {
      messages.assignAll(savedMessages);
    } else {
      _addWelcomeMessage();
    }
    if (savedSession != null) {
      sessionId.value = savedSession;
    }
  }
}
