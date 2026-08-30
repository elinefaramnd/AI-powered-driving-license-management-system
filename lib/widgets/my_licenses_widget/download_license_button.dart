import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class DownloadLicenseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const DownloadLicenseButton({
    super.key,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;
    return Container(
      width: double.infinity,
      height: h * 0.062,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.035),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.35),
          width: w * 0.0025,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: w * 0.02,
            offset: Offset(
              0,
              h * 0.0035,
            ),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(w * 0.035),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(w * 0.035),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.download_rounded,
                color: AppColors.primaryColor,
                size: w * 0.055,
              ),
              SizedBox(
                width: w * 0.025,
              ),
              Text(
                "download_license".tr,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}