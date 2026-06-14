import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/settings_support/models/settings_model.dart';
import '../../modules/settings_support/settings_controller.dart';

class AccountInfoCardWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final AccountInfo? account;
  final SettingsController controller;

  const AccountInfoCardWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.account,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.04,
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  const Text(
                    'معلومات الحساب',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.18,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: screenWidth * 0.1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('الاسم الكامل', account?.name ?? ''),
                        SizedBox(height: screenHeight * 0.006),
                        _buildInfoRow('البريد الإلكتروني', account?.email ?? ''),
                        SizedBox(height: screenHeight * 0.006),
                        _buildInfoRow('رقم الهاتف', account?.phone ?? ''),
                        SizedBox(height: screenHeight * 0.006),
                        _buildInfoRow('الرقم الوطني', account?.nationalId.isNotEmpty == true ? account!.nationalId : 'غير متوفر'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Divider(color: Colors.black, thickness: 0.3),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          controller.profileStatusText,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'حالة الملف الشخصي',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.015),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                children: [
                  Text(
                    '${controller.profileCompletionPercentage.toInt()}%',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: controller.profileCompletionPercentage / 100,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    controller.profileStatusDescription,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
