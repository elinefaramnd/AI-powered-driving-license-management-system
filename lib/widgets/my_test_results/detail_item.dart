import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class DetailItem extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String title;
  final String value;
  final Color valueColor;
  final bool isArabic;

  const DetailItem({
    super.key,
    required this.size,
    required this.icon,
    required this.title,
    required this.value,
    required this.valueColor,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.035,
        vertical: size.height * 0.014,
      ),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Container(
                width: size.width * 0.065,
                height: size.width * 0.065,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: size.width * 0.04,
                ),
              ),
              SizedBox(width: size.width * 0.025),
              Text(
                title.tr,
                style: TextStyle(
                  fontSize: size.width * 0.031,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Align(
              alignment: isArabic
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                value,
                textAlign: isArabic ? TextAlign.left : TextAlign.right,
                style: TextStyle(
                  fontSize: size.width * 0.032,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailDivider extends StatelessWidget {
  const DetailDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color(0xffE8E4DC),
    );
  }
}
