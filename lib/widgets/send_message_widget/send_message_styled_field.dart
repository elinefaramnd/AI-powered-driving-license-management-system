import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:project_2/app_theme/app_colors.dart';

class SendMessageFieldLabel extends StatelessWidget {
  final double w;

  final String label;

  final IconData icon;

  const SendMessageFieldLabel({
    super.key,
    required this.w,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";

    return Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,

      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Icon(icon, color: AppColors.primaryColor, size: 18),

        SizedBox(width: w * 0.02),

        Text(
          label,

          textAlign: isArabic ? TextAlign.right : TextAlign.left,

          style: TextStyle(
            fontSize: w * 0.038,

            fontWeight: FontWeight.w600,

            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

class SendMessageStyledField extends StatelessWidget {
  final TextEditingController controller;

  final String hint;

  final TextInputType keyboardType;

  final double w;

  final int maxLines;

  final bool isLtr;

  final bool readOnly;

  const SendMessageStyledField({
    super.key,

    required this.controller,

    required this.hint,

    required this.keyboardType,

    required this.w,

    this.maxLines = 1,

    this.isLtr = false,

    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,

      child: TextField(
        controller: controller,

        keyboardType: keyboardType,

        maxLines: maxLines,

        readOnly: readOnly,

        textDirection: isLtr
            ? TextDirection.ltr
            : (isArabic ? TextDirection.rtl : TextDirection.ltr),

        textAlign: isLtr
            ? TextAlign.left
            : (isArabic ? TextAlign.right : TextAlign.left),

        cursorColor: AppColors.primaryColor,

        decoration: InputDecoration(
          hintText: hint,

          hintTextDirection: isLtr
              ? TextDirection.ltr
              : (isArabic ? TextDirection.rtl : TextDirection.ltr),

          hintStyle: TextStyle(
            fontSize: w * 0.035,

            color: Colors.grey.shade400,
          ),

          prefix: readOnly
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(start: 2, end: 8),

                  child: Icon(
                    Icons.lock_outline_rounded,

                    color: AppColors.primaryColor,

                    size: 18,
                  ),
                )
              : null,

          filled: true,

          fillColor: readOnly ? const Color(0xFFEEF2F0) : AppColors.bgColor,

          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.04,

            vertical: maxLines > 1 ? w * 0.04 : w * 0.035,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
