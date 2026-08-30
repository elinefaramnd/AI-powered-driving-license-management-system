import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
class EmptyLicensesState extends StatelessWidget {
  const EmptyLicensesState({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: media.size.width * 0.09,
          vertical: media.size.height * 0.025,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: media.size.width * 0.21,
              height: media.size.width * 0.21,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.25),
                ),
              ),
              child: Icon(
                Icons.badge_outlined,
                size: media.size.width * 0.11,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: media.size.height * 0.022),
            Text(
              "no_licenses".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: media.size.width * 0.048,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: media.size.height * 0.009),
            Text(
              "no_licenses_message".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: media.size.width * 0.03,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}