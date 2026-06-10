import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/chat_bot_controller.dart';

class ChatBotScreen extends StatelessWidget {
  ChatBotScreen({super.key});

  final ChatBotController controller = Get.find();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'المساعد الذكي',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: size.width * 0.05,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.more_vert,
        //       color: Colors.white,
        //       size: size.width * 0.06,
        //     ),
        //   ),
        // ],
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
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.02,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(message, size);
                },
              );
            }),
          ),
          _buildInputArea(size),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, Size size) {
    final isUser = message.isUser;

    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * 0.015,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold,
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: size.width * 0.05,
              ),
            ),
          if (!isUser) SizedBox(width: size.width * 0.02),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.width * 0.04),
                  topRight: Radius.circular(size.width * 0.04),
                  bottomLeft: Radius.circular(isUser ? size.width * 0.04 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : size.width * 0.04),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: size.width * 0.02,
                    offset: Offset(0, size.height * 0.005),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: size.width * 0.035,
                      height: 1.5,
                    ),
                  ),
                  if (message.hasAttachment)
                    _buildAttachment(message.attachmentName!, size),
                  if (message.showActionButtons)
                    _buildActionButtons(size),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isUser ? Colors.white70 : Colors.grey,
                      fontSize: size.width * 0.025,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) SizedBox(width: size.width * 0.02),
          if (isUser)
            Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkGreen,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: size.width * 0.05,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttachment(String fileName, Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.008,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(size.width * 0.02),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.attach_file,
            size: size.width * 0.04,
            color: AppColors.gold,
          ),
          SizedBox(width: size.width * 0.02),
          Flexible(
            child: Text(
              fileName,
              style: TextStyle(
                color: Colors.black87,
                fontSize: size.width * 0.03,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.015),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _buildActionButton(
              'قبول',
              Icons.check_circle,
              AppColors.primary,
              () => controller.acceptPrompt(),
              size,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: _buildActionButton(
              'رفض',
              Icons.cancel,
              Colors.red.shade400,
              () => controller.rejectPrompt(),
              size,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
    Size size,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(size.width * 0.02),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: size.width * 0.04,
              color: color,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: size.width * 0.032,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: size.width * 0.03,
            offset: Offset(0, -size.height * 0.005),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (controller.selectedFileName.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                margin: EdgeInsets.only(bottom: size.height * 0.01),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      size: size.width * 0.04,
                      color: AppColors.gold,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Flexible(
                      child: Text(
                        controller.selectedFileName.value,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: size.width * 0.03,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () => controller.clearSelectedFile(),
                      child: Icon(
                        Icons.close,
                        size: size.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
            Row(
              children: [
                _buildUploadButton(size),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(size.width * 0.08),
                      border: Border.all(
                        color: AppColors.gold.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'اكتب رسالتك هنا...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width * 0.035,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                                vertical: size.height * 0.015,
                              ),
                            ),
                            onSubmitted: (text) async => await _sendMessageToBackend(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                _buildSendButton(size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(Size size) {
    return GestureDetector(
      onTap: () async => await controller.pickFile(),
      child: Container(
        width: size.width * 0.12,
        height: size.width * 0.12,
        decoration: BoxDecoration(
          color: AppColors.gold.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.attach_file,
          color: AppColors.gold,
          size: size.width * 0.05,
        ),
      ),
    );
  }

  Widget _buildSendButton(Size size) {
    return GestureDetector(
      onTap: () async => await _sendMessageToBackend(),
      child: Container(
        width: size.width * 0.12,
        height: size.width * 0.12,
        decoration: BoxDecoration(
          color: AppColors.gold,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.3),
              blurRadius: size.width * 0.02,
              offset: Offset(0, size.height * 0.005),
            ),
          ],
        ),
        child: Icon(
          Icons.send,
          color: Colors.white,
          size: size.width * 0.05,
        ),
      ),
    );
  }

  Future<void> _sendMessageToBackend() async {
    final text = messageController.text.trim();
    if (text.isNotEmpty || controller.selectedFileName.value.isNotEmpty) {
      await controller.sendMessageToBackend(text);
      messageController.clear();
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
