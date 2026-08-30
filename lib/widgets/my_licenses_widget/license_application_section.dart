import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/my_licenses/license_model.dart';

class LicenseApplicationSection extends StatelessWidget {
  final LicenseModel license;
  final String remainingDays;
  const LicenseApplicationSection({
    super.key,
    required this.license,
    required this.remainingDays,
  });
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * .01),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gold.withOpacity(.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: w * .08,
            height: w * .08,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EFE1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.link,
              color: AppColors.gold,
            ),
          ),
          SizedBox(width: w * .02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "linked_application".tr,
                  style: TextStyle(color: Colors.grey.shade600,
                  fontSize: w * .033),
                ),
                Text(
                  license.application.applicationNumber,
                  style:  TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .032
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}