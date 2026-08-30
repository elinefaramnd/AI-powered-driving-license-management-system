import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/chat_bot/chat_message.dart';
import '../../widgets/chat_bot_widget/chat_bot_app_bar.dart';
import '../../widgets/chat_bot_widget/chat_message_bubble.dart';
import '../../widgets/chat_bot_widget/input_area.dart';
import '../../widgets/chat_bot_widget/typing_indicator.dart';
import '../home_page/home_controller.dart';
import 'chat_bot_controller.dart';

class ChatBotScreen extends StatelessWidget {
  ChatBotScreen({super.key});
  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      appBar: ChatBotAppBar(
        size: size,
        onBack: () async {
          final shouldRefresh = controller.hasInteracted;
          Get.back();
          if (shouldRefresh) {
            final homeController = Get.find<HomeController>();
            await homeController.loadHome();
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.04,
                  size.height * 0.018,
                  size.width * 0.04,
                  size.height * 0.015,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return ChatMessageBubble(
                    message: message,
                    size: size,
                    controller: controller,
                  );
                },
              );
            }),
          ),
          Obx(() {
            return ChatTypingIndicator(
              size: size,
              isTyping: controller.isTyping.value,
            );
          }),
          InputArea(
            size: size,
            controller: controller,
            messageController: messageController,
            onSendMessage: _sendMessageToBackend,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessageToBackend() async {
    final text = messageController.text.trim();
    final hasFile =
        controller.selectedFileName.value.isNotEmpty &&
        controller.selectedFile != null;
    if (text.isEmpty && !hasFile) {
      return;
    }
    if (hasFile) {
      final fileName = controller.selectedFileName.value;
      final file = controller.selectedFile;
      controller.messages.add(
        ChatMessage(
          text: fileName,
          isUser: true,
          timestamp: DateTime.now(),
          hasAttachment: true,
          attachmentName: fileName,
          attachmentFile: file,
        ),
      );
      controller.selectedFileName.value = '';
      messageController.clear();
      controller.isTyping.value = true;
      await controller.uploadRequiredDocument();
      return;
    }
    messageController.clear();
    if (text.isNotEmpty) {
      await controller.sendMessageToBackend(text);
    }
  }
}
