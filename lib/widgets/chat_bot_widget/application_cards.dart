import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
class ApplicationCards extends StatelessWidget {
  final List<Map<String, dynamic>> applications;
  final Size size;
  final ChatController controller;
  const ApplicationCards({
    super.key,
    required this.applications,
    required this.size,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.018),
        child: Column(
          children: applications.map((application) {
            final label = application['label']?.toString() ?? '';
            final subtitle = application['subtitle']?.toString() ?? '';
            final selectionToken = application['selection_token']?.toString() ?? '';
            final statusLabel = application['status_label']?.toString() ?? '';
            return Container(
              margin: EdgeInsets.only(bottom: size.height * 0.014),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: const Border(
                  left: BorderSide(color: AppColors.gold, width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.055),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: selectionToken.isEmpty
                      ? null
                      : () async {
                    await controller.selectApplication(
                      selectionToken,
                      label,
                    );
                  },
                  borderRadius: BorderRadius.circular(22),
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.035),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: isArabic
                              ? [
                            _documentIcon(),
                            SizedBox(width: size.width * 0.028),
                            Expanded(
                              child: _applicationInfo(
                                label: label,
                                subtitle: subtitle,
                                isArabic: true,
                              ),
                            ),
                          ]
                              : [
                            _documentIcon(),
                            SizedBox(width: size.width * 0.028),
                            Expanded(
                              child: _applicationInfo(
                                label: label,
                                subtitle: subtitle,
                                isArabic: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.014),
                        Row(
                          children: [
                            if (statusLabel.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.027,
                                  vertical: size.height * 0.007,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F5F3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      statusLabel,
                                      textAlign: isArabic
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: size.width * 0.025,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.010),
                                    Container(
                                      width: size.width * 0.014,
                                      height: size.width * 0.014,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF8AAFA6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: selectionToken.isEmpty
                                    ? null
                                    : () async {
                                  await controller.selectApplication(
                                    selectionToken,
                                    label,
                                  );
                                },
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.042,
                                    vertical: size.height * 0.012,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.16),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'chatbot_select'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.032,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget _documentIcon() {
    return Container(
      width: size.width * 0.145,
      height: size.width * 0.145,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F4),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.gold.withOpacity(0.12)),
      ),
      child: Icon(
        Icons.description_outlined,
        color: AppColors.gold,
        size: size.width * 0.070,
      ),
    );
  }
  Widget _applicationInfo({
    required String label,
    required String subtitle,
    required bool isArabic,
  }) {
    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            label,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: size.width * (isArabic ? 0.031 : 0.028),

              fontWeight: FontWeight.w800,
              letterSpacing: isArabic ? 0.2 : 0,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.007),
        SizedBox(
          width: double.infinity,
          child: Text(
            subtitle,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: size.width * (isArabic ? 0.038 : 0.032),

              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.008),
        SizedBox(
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.gold,
                  size: size.width * 0.033,
                ),
                SizedBox(width: size.width * 0.008),
                Text(
                  _licenseType(subtitle, true),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: size.width * 0.027,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]
          ),
        ),
      ],
    );
  }
  String _licenseType(String subtitle, bool isArabic) {
    final value = subtitle.toLowerCase().trim();
    if (value.contains('عامة') ||
        value.contains('general') ||
        value.contains('public')) {
      return 'license_general'.tr;
    }
    if (value.contains('خاصة') || value.contains('private')) {
      return 'license_private'.tr;
    }
    if (value.contains('شاحنة') || value.contains('truck')) {
      return 'license_truck'.tr;
    }
    if (value.contains('حافلة') || value.contains('bus')) {
      return 'license_bus'.tr;
    }
    return value.isEmpty ? 'license'.tr : subtitle;
  }
}
