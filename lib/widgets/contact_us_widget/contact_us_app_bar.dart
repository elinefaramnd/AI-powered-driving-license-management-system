import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';

class ContactUsAppBar extends StatelessWidget {
  final double w;
  const ContactUsAppBar({super.key, required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.045, vertical: w * 0.035),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightGreenBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.darkGreen, size: 18),
            ),
          ),
          const Spacer(),
          Text(
            'تواصل معنا',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: w * 0.048,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),
          SizedBox(width: w * 0.02),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGreenBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.headset_mic_rounded,
                color: AppColors.mediumGreen, size: 20),
          ),
        ],
      ),
    );
  }
}
