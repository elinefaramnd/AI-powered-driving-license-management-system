import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import 'chat_bot_painters.dart';

class RequiredDocumentCard extends StatelessWidget {
  final ChatController controller;
  final String label;
  final String status;
  final String selectionToken;
  final Size size;

  const RequiredDocumentCard({
    super.key,
    required this.controller,
    required this.label,
    required this.status,
    required this.selectionToken,
    required this.size,
  });

  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: InkWell(
        onTap: selectionToken.isEmpty
            ? null
            : () async {
                await controller.selectRequiredDocument(selectionToken, label);
              },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.065),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: GoldCornerClipper(),
                  child: Container(
                    width: size.width * 0.055,
                    height: size.width * 0.055,
                    color: AppColors.gold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.025,
                  vertical: size.height * 0.016,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.105,
                      height: size.width * 0.105,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F8F6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.08),
                        ),
                      ),
                      child: Icon(
                        _documentIcon(label),
                        color: AppColors.primaryColor,
                        size: size.width * 0.060,
                      ),
                    ),
                    SizedBox(height: size.height * 0.010),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textDark,
                        fontSize: size.width * (isArabic ? 0.028 : 0.025),
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: size.height * 0.007),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.025,
                        vertical: size.height * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEEF0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status == 'missing'
                            ? 'chatbot_required_status'.tr
                            : status,
                        style: TextStyle(
                          color: const Color(0xFFD66A72),
                          fontSize: size.width * (isArabic ? 0.022 : 0.020),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.010),
                    SizedBox(
                      width: size.width * 0.25,
                      height: size.height * 0.035,
                      child: Material(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: selectionToken.isEmpty
                              ? null
                              : () async {
                                  await controller.selectRequiredDocument(
                                    selectionToken,
                                    label,
                                  );
                                },
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: isArabic
                                ? [
                                    Text(
                                      'chatbot_select'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.025,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.012),
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                      color: Colors.white,
                                      size: size.width * 0.033,
                                    ),
                                  ]
                                : [
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                      color: Colors.white,
                                      size: size.width * 0.030,
                                    ),
                                    SizedBox(width: size.width * 0.010),
                                    Text(
                                      'chatbot_select'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.022,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _documentIcon(String label) {
    final value = label.toLowerCase();
    if (value.contains('شخصية') || value.contains('personal')) {
      return Icons.person_outline_rounded;
    }
    if (value.contains('طبي') || value.contains('medical')) {
      return Icons.favorite_border_rounded;
    }
    if (value.contains('هوية') || value.contains('identity')) {
      return Icons.badge_outlined;
    }
    if (value.contains('دم') || value.contains('blood')) {
      return Icons.water_drop_outlined;
    }
    if (value.contains('رخص') || value.contains('license')) {
      return Icons.credit_card_outlined;
    }
    return Icons.description_outlined;
  }
}
