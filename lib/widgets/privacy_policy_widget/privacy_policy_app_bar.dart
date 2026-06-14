import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';

class PrivacyPolicyAppBar extends StatelessWidget {
  final double w;
  const PrivacyPolicyAppBar({super.key, required this.w});

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.045, vertical: w * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_forward_ios, size: 18, color:AppColors.darkGreen),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Syrtak',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.shield, color:  AppColors.darkGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
