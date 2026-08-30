import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';

class SelectedFilePreview extends StatelessWidget {
  final ChatController controller;
  final Size size;
  const SelectedFilePreview({
    super.key,
    required this.controller,
    required this.size,
  });
  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.010),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.030,
        vertical: size.height * 0.009,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withOpacity(0.20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // FILE ICON
          Container(
            width: size.width * 0.085,
            height: size.width * 0.085,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.insert_drive_file_rounded,
              color: AppColors.gold,
              size: size.width * 0.042,
            ),
          ),
          SizedBox(width: size.width * 0.020),
          Expanded(
            child: Text(
              controller.selectedFileName.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: textDark,
                fontSize: size.width * 0.029,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.clearSelectedFile();
            },
            child: Container(
              width: size.width * 0.075,
              height: size.width * 0.075,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.045),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.grey.shade600,
                size: size.width * 0.040,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
