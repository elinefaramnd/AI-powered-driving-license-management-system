import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class FaqSearchBar extends StatelessWidget {
  final double w;
  final TextEditingController searchController;
  final Function(String) onChanged;

  const FaqSearchBar({
    super.key,
    required this.w,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.045),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Directionality(
        textDirection:
        isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          textDirection:
          isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Icon(
              Icons.search_rounded,
              color: AppColors.primaryColor,
              size: 22,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: onChanged,
                textAlign:
                isArabic ? TextAlign.right : TextAlign.left,
                textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "search_question".tr,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: w * 0.037,
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
