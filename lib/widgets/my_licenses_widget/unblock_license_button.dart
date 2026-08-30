import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class UnblockLicenseButton extends StatelessWidget {
  final VoidCallback onPressed;
  const UnblockLicenseButton({
    super.key,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          Icons.lock_open_outlined,
          size: w * 0.055,
        ),
        label: Text(
          "license_unblock_next_step".tr,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: w * 0.035,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.35),
            width: w * 0.003,
          ),
          backgroundColor:
          AppColors.primaryColor.withOpacity(0.04),
          padding: EdgeInsets.symmetric(
            vertical: h * 0.015,
            horizontal: w * 0.035,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w * 0.035),
          ),
        ),
      ),
    );
  }
}