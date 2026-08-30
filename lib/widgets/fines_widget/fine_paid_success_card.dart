import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class FinePaidSuccessCard extends StatelessWidget {
  const FinePaidSuccessCard({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(w * .04),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(w * .035),
        border: Border.all(color: AppColors.primaryColor.withOpacity(.25)),
      ),
      child: Row(
        children: [
          Container(
            width: w * .12,
            height: w * .12,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: w * .07),
          ),
          SizedBox(width: w * .035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "payment_completed".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: w * .042,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * .01),
                Text(
                  "payment_completed_successfully".tr,
                  style: TextStyle(color: Colors.grey[700], fontSize: w * .033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
