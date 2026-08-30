import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import '../../modules/chat_bot/chat_message.dart';
import 'application_cards.dart';
import 'appointment_cards.dart';
import 'chat_bot_avatars.dart';
import 'chat_attachment.dart';
import 'chat_action_buttons.dart';
import 'confirmation_message.dart';
import 'document_cards.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final Size size;
  final ChatController controller;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.size,
    required this.controller,
  });
  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final isUser = message.isUser;
    if (!isUser && message.showActionButtons) {
      return ConfirmationMessage(
        message: message,
        size: size,
        controller: controller,
      );
    }
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.018),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser) ...[
              ChatBotAvatar(size: size),
              SizedBox(width: size.width * 0.018),
            ],
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.82),
                padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  top: size.height * 0.014,
                  bottom: size.height * 0.012,
                ),
                decoration: BoxDecoration(
                  color: isUser ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.045),
                    topRight: Radius.circular(size.width * 0.045),
                    bottomLeft: Radius.circular(
                      isUser ? size.width * 0.045 : 6,
                    ),
                    bottomRight: Radius.circular(
                      isUser ? 6 : size.width * 0.045,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isUser ? 0.10 : 0.055),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.text.isNotEmpty)
                      Text(
                        message.text.tr,
                        textAlign: isUser ? TextAlign.right : TextAlign.right,
                        style: TextStyle(
                          color: isUser ? Colors.white : textDark,
                          fontSize: size.width * 0.035,
                          height: 1.55,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (message.hasAttachment)
                      ChatAttachment(
                        fileName: message.attachmentName!,
                        size: size,
                        isUser: isUser,
                      ),
                    if (message.showActionButtons)
                      ChatActionButtons(
                        size: size,
                        acceptLabel: "chatbot_accept".tr,
                        rejectLabel: "chatbot_reject".tr,
                        onAccept: () => controller.acceptPrompt(),
                        onReject: () => controller.rejectPrompt(),
                      ),
                    if (message.applications.isNotEmpty)
                      ApplicationCards(
                        applications: message.applications,
                        size: size,
                        controller: controller,
                      ),
                    if (message.appointmentSlots.isNotEmpty)
                      AppointmentCards(
                        slots: message.appointmentSlots,
                        size: size,
                        controller: controller,
                      ),
                    if (message.documents.isNotEmpty)
                      DocumentCards(
                        documents: message.documents,
                        buttons: message.documentButtons,
                        size: size,
                        controller: controller,
                      ),
                    SizedBox(height: size.height * 0.007),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isUser)
                          Icon(
                            Icons.done_all,
                            size: size.width * 0.037,
                            color: Colors.white.withOpacity(0.70),
                          ),
                        if (isUser) SizedBox(width: size.width * 0.012),
                        Text(
                          _formatTime(message.timestamp),
                          style: TextStyle(
                            color: isUser
                                ? Colors.white.withOpacity(0.62)
                                : Colors.grey.shade500,
                            fontSize: size.width * 0.024,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isUser) ...[
              SizedBox(width: size.width * 0.018),
              ChatUserAvatar(size: size),
            ],
          ],
        ),
      ),
    );
  }
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
