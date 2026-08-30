import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';

class SendMessageHeaderBanner extends StatelessWidget {
  final double w;
  final double h;
  const SendMessageHeaderBanner({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.055, vertical: h * 0.025),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [AppColors.primaryColor, AppColors.darkGreen],
          begin:
          isArabic ? Alignment.topLeft : Alignment.topRight,

          end:
          isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        textDirection:
        isArabic ? TextDirection.rtl : TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              "send_message_banner".tr,
              textAlign:
              isArabic ? TextAlign.right : TextAlign.left,
              textDirection:
              isArabic ? TextDirection.rtl : TextDirection.ltr,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: w * 0.036,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(width: w * 0.03),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}
