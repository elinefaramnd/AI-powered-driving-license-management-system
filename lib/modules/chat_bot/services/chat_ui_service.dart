import 'package:project_2/modules/chat_bot/chat_message.dart';

class ChatUiService {
  ChatMessage buildUserMessage(String text) {
    return ChatMessage(text: text, isUser: true, timestamp: DateTime.now());
  }

  ChatMessage buildBotMessage(
    String text, {
    bool showActionButtons = false,
    List<Map<String, dynamic>>? appointmentSlots,
    List<Map<String, dynamic>>? documents,
    List<Map<String, dynamic>>? documentButtons,
    String? uploadToken,
    List<String>? allowedExtensions,
  }) {
    return ChatMessage(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
      showActionButtons: showActionButtons,
      appointmentSlots: appointmentSlots ?? [],
      documents: documents ?? [],
      documentButtons: documentButtons ?? [],
      uploadToken: uploadToken ?? '',
      allowedExtensions: allowedExtensions ?? [],
    );
  }

  List<Map<String, dynamic>> extractList(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }
}
