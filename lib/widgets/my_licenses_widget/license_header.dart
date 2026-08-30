import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/my_licenses/license_model.dart';

class LicenseHeader extends StatelessWidget {
  final LicenseModel license;
  final String statusText;

  const LicenseHeader({
    super.key,
    required this.license,
    required this.statusText,
  });
  String _remainingDays() {
    final expiry = DateTime.parse(license.expiryDate);
    final difference = expiry.difference(DateTime.now()).inDays;
    if (difference > 0) {
      return "remaining_days".trParams({
        "days": difference.toString(),
      });
    }
    if (difference == 0) {
      return "expires_today".tr;
    }
    return "expired_since".trParams({
      "days": difference.abs().toString(),
    });
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isArabic = Get.locale?.languageCode == "ar";

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: media.size.width * .04,
        vertical: media.size.height * .018,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            width: media.size.width * .07,
            height: media.size.width * .07,
            decoration: const BoxDecoration(
              color: Color(0xFF0E6A4D),
              shape: BoxShape.circle,
            ),
            child: Icon(
              license.status.toLowerCase() == "blocked"
                  ? Icons.block_rounded
                  : Icons.verified,
              color: Colors.white,
              size: media.size.width * .05,
            )
          ),

          SizedBox(width: media.size.width * .025),

          Expanded(
            child: Text(
              statusText,
              style: TextStyle(
                color: const Color(0xFFB7F1C5),
                fontWeight: FontWeight.bold,
                fontSize: media.size.width * .042,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: media.size.width * .03,
              vertical: media.size.height * .007,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              _remainingDays(),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: media.size.width * .028,
              ),
            ),
          ),
        ],
      ),
    );
  }
}