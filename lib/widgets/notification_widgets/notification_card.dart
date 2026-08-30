import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/notification/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final Size size;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.size,
    required this.onTap,
  });
  IconData _getIcon() {
    switch (notification.type) {
      case "payment.completed":
      case "application.payment_pending":
        return Icons.credit_card_outlined;
      case "application.approved":
        return Icons.check_circle_outline;
      case "application.created":
        return Icons.description_outlined;
      case "application.documents_under_review":
        return Icons.fact_check_outlined;
      case "document.approved":
        return Icons.verified_outlined;
      case "license.issued":
        return Icons.badge_outlined;
      case "license.blocked":
        return Icons.block_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final isArabic = Get.locale?.languageCode == "ar";
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.all(size.width * .04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * .09,
                height: size.width * .09,
                decoration: BoxDecoration(
                  color: isUnread
                      ? AppColors.primaryColor
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(),
                  color: isUnread ? Colors.white : AppColors.primaryColor,
                  size: size.width * .05,
                ),
              ),
              SizedBox(width: size.width * .035),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            textAlign: isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            style: TextStyle(
                              color: isUnread
                                  ? Colors.black87
                                  : Colors.grey.shade600,
                              fontSize: size.width * .038,
                              fontWeight: isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: size.height * .006),
                    Text(
                      notification.body,
                      textAlign: isArabic
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        height: 1.45,
                        fontSize: size.width * .032,
                      ),
                    ),
                    SizedBox(height: size.height * .01),
                    Text(
                      _formatDate(notification.createdAt),
                      textAlign: isArabic
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: size.width * .027,
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

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat(
      "yyyy/MM/dd  HH:mm",
      Get.locale?.languageCode == "ar" ? "ar" : "en",
    ).format(date.toLocal());
  }
}
