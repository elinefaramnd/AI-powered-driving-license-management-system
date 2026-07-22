import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final w = size.width;
    final h = size.height;
    return Container(
      width: double.infinity,
      height: h * 0.17,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
        vertical: h * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.025),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/download1.png",
            width: w * 0.32,
            height: w * 0.32,
            fit: BoxFit.contain,
          ),
          SizedBox(width:  w * 0.038),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   "documents_completed".tr,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:isRtl? w * 0.044:w * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                   "documents_completed_description".tr,
                   textAlign: isRtl ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: w * 0.029,
                  ),
                ),
                SizedBox(height:  h * 0.019),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.013,
                    vertical: h * 0.0012,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.075),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: w * 0.05,
                      ),
                      SizedBox(width:  w * 0.013),
                      Text(
                      "under_review".tr,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize:isRtl? w * 0.035:w * 0.033,
                        ),
                      ),
                    ],
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