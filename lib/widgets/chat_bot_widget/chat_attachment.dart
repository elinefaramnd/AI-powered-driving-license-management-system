import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ChatAttachment extends StatelessWidget {
  final String fileName;
  final Size size;
  final bool isUser;
  const ChatAttachment({
    super.key,
    required this.fileName,
    required this.size,
    required this.isUser,
  });
  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.012,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.010,
      ),
      decoration: BoxDecoration(
        color: isUser
            ? Colors.white.withOpacity(0.10)
            : AppColors.gold,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isUser
              ? Colors.white.withOpacity(0.20)
              : AppColors.gold.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width * 0.075,
            height: size.width * 0.075,
            decoration: BoxDecoration(
              color: isUser
                  ? Colors.white.withOpacity(0.12)
                  : AppColors.gold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.insert_drive_file_rounded,
              color: isUser
                  ? Colors.white
                  : AppColors.gold,
              size: size.width * 0.04,
            ),
          ),
          SizedBox(
            width: size.width * 0.025,
          ),
          Flexible(
            child: Text(
              fileName,
              style: TextStyle(
                color: isUser
                    ? Colors.white
                    : textDark,
                fontSize: size.width * 0.029,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}