import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';

class ContactUsSectionLabel extends StatelessWidget {
  final double w;
  final String label;
  final IconData icon;
  const ContactUsSectionLabel({super.key, required this.w, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Row(
      textDirection:
      isArabic ? TextDirection.rtl : TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.lightGreenBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.mediumGreen, size: 20),
        ),
        SizedBox(width: w * 0.025),
        Text(
          label,
          textDirection:
          isArabic ? TextDirection.rtl : TextDirection.ltr,

          textAlign:
          isArabic ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: w * 0.045,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
      ],
    );
  }
}
