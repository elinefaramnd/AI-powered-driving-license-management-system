import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
class UploadButton extends StatelessWidget {
  final ChatController controller;
  final Size size;
  const UploadButton({
    super.key,
    required this.controller,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.pickFile();
      },
      child: Container(
        width: size.width * 0.095,
        height: size.width * 0.095,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.attach_file_rounded,
          color: AppColors.gold,
          size: size.width * 0.050,
        ),
      ),
    );
  }
}