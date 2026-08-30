import 'package:get_storage/get_storage.dart';
import '../chat_message.dart';

class ChatStorageService {
  final GetStorage box = GetStorage();
  Future<void> saveChat({
    required String userId,
    required List<ChatMessage> messages,
    required int? sessionId,
  }) async {
    final messagesKey = 'chat_messages_$userId';
    final sessionKey = 'chat_session_$userId';
    await box.write(
      messagesKey,
      messages.map((message) => message.toJson()).toList(),
    );
    if (sessionId != null) {
      await box.write(sessionKey, sessionId);
    }
  }

  List<ChatMessage> loadMessages(String userId) {
    final saved = box.read('chat_messages_$userId');
    if (saved is! List) {
      return [];
    }
    return saved
        .whereType<Map>()
        .map((item) => ChatMessage.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  int? loadSession(String userId) {
    final saved = box.read('chat_session_$userId');

    if (saved == null) {
      return null;
    }

    return int.tryParse(saved.toString());
  }
}
