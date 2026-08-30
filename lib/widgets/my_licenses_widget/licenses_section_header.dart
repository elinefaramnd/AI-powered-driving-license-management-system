import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';

class LicensesSectionHeader extends StatelessWidget {
  final bool isArabic;
  const LicensesSectionHeader({super.key, required this.isArabic});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Text(
      "licenses_list".tr,
      style: TextStyle(
        color: AppColors.primaryColor,
        fontSize: media.size.width * .05,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
