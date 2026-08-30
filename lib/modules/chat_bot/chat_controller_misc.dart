part of 'chat_bot_controller.dart';

extension ChatControllerMisc on ChatController {
  void _addWelcomeMessage() {
    messages.add(
      ChatMessage(
        text: 'chatbot_welcome',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> saveChat() async {
    final currentUserId = box.read('user_id');

    if (currentUserId == null) {
      print('Cannot save chat: user_id is null');
      return;
    }

    await storage.saveChat(
      userId: currentUserId.toString(),
      messages: messages.toList(),
      sessionId: sessionId.value,
    );
  }

  void markAsInteracted() {
    hasInteracted = true;
  }

  void close() {
    showMessage.value = false;
  }

  Future<void> openChatScreen() async {
    Get.to(() => ChatBotScreen());
  }

  Future<void> loadMessages() async {}

  void onNewMessageFromBackend(Map<String, dynamic> messageData) {
    messages.add(
      ChatMessage(
        text: messageData['text'] ?? '',
        isUser: false,
        timestamp: DateTime.parse(
          messageData['timestamp'] ?? DateTime.now().toIso8601String(),
        ),
        showActionButtons: messageData['show_actions'] ?? false,
      ),
    );
  }
}
