import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';

class AppointmentCards extends StatelessWidget {
  final List<Map<String, dynamic>> slots;
  final Size size;
  final ChatController controller;

  const AppointmentCards({
    super.key,
    required this.slots,
    required this.size,
    required this.controller,
  });

  static const Color textDark = Color(0xFF202624);

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.018),
        child: Column(
          children: slots.map((slot) {
            final label = slot['label']?.toString() ?? '';
            final date = slot['date']?.toString() ?? '';
            final time = slot['time']?.toString() ?? '';
            final center = slot['center']?.toString() ?? '';

            final selectionToken = slot['selection_token']?.toString() ?? '';

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
                  borderRadius: BorderRadius.circular(22),
                  onTap: selectionToken.isEmpty
                      ? null
                      : () async {
                          await controller.selectAppointmentSlot(
                            selectionToken,
                            label,
                          );
                        },
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.035),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.145,
                              height: size.width * 0.145,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9F8F4),
                                borderRadius: BorderRadius.circular(17),
                                border: Border.all(
                                  color: AppColors.gold.withOpacity(0.12),
                                ),
                              ),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: AppColors.gold,
                                size: size.width * 0.070,
                              ),
                            ),
                            SizedBox(width: size.width * 0.028),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    label,
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: size.width * 0.031,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.008),
                                  Row(
                                    mainAxisAlignment: isArabic
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: isArabic
                                        ? [
                                            Flexible(
                                              child: Text(
                                                center,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: size.width * 0.027,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.008),
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.gold,
                                              size: size.width * 0.033,
                                            ),
                                          ]
                                        : [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.gold,
                                              size: size.width * 0.030,
                                            ),
                                            SizedBox(width: size.width * 0.008),
                                            Flexible(
                                              child: Text(
                                                center,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: size.width * 0.024,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: size.height * 0.014),

                        Row(
                          children: [
                            Expanded(
                              child: _infoBox(
                                icon: Icons.calendar_today_rounded,
                                title: 'appointment_date'.tr,
                                value: date,
                                isArabic: isArabic,
                              ),
                            ),
                            SizedBox(width: size.width * 0.025),
                            Expanded(
                              child: _infoBox(
                                icon: Icons.access_time_rounded,
                                title: 'appointment_time'.tr,
                                value: time,
                                isArabic: isArabic,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: size.height * 0.014),

                        Row(
                          children: [
                            const Spacer(),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(13),
                                onTap: selectionToken.isEmpty
                                    ? null
                                    : () async {
                                        await controller.selectAppointmentSlot(
                                          selectionToken,
                                          label,
                                        );
                                      },
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        color: Colors.white,
                                        size: size.width * 0.040,
                                      ),

                                      SizedBox(width: size.width * 0.010),

                                      Text(
                                        'appointment_select'.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              size.width *
                                              (isArabic ? 0.032 : 0.028),
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

  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
    required bool isArabic,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.025,
        vertical: size.height * 0.010,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F8F4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gold.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: size.width * 0.038),

          SizedBox(width: size.width * 0.015),

          Expanded(
            child: Column(
              crossAxisAlignment: isArabic
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: size.width * (isArabic ? 0.024 : 0.021),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: size.height * 0.003),

                Text(
                  value,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textDark,
                    fontSize: size.width * (isArabic ? 0.028 : 0.025),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
