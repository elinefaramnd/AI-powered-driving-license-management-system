import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import 'selected_file_preview.dart';
import 'upload_button.dart';
import 'send_button.dart';

class InputArea extends StatelessWidget {
  final ChatController controller;
  final TextEditingController messageController;
  final Size size;
  final Future<void> Function() onSendMessage;
  const InputArea({
    super.key,
    required this.controller,
    required this.messageController,
    required this.size,
    required this.onSendMessage,
  });
  static const Color lightBackground = Color(0xFFF7F7F4);
  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightBackground,
      padding: EdgeInsets.fromLTRB(
        size.width * 0.035,
        size.height * 0.010,
        size.width * 0.035,
        size.height * 0.010,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Obx(() {
              if (controller.selectedFileName.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return SelectedFilePreview(controller: controller, size: size);
            }),
            Container(
              height: size.height * 0.070,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.010),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38),
                border: Border.all(color: Colors.grey.withOpacity(0.10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  UploadButton(controller: controller, size: size),
                  SizedBox(width: size.width * 0.012),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: TextStyle(
                        color: textDark,
                        fontSize: size.width * 0.034,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "chatbot_hint".tr,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: size.width * 0.032,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.015,
                        ),
                      ),
                      onSubmitted: (text) async {
                        await onSendMessage();
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.012),
                  SendButton(size: size, onTap: onSendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
