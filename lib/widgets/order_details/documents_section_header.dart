import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class DocumentsSectionHeader extends StatelessWidget {
  const DocumentsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.02,
                  ),
                  child: Icon(
                    Icons.fact_check_outlined,
                    color: AppColors.primaryColor,
                    size: w * 0.06,
                  ),
                ),
                Text(
                  "attached_documents".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:isRtl?w * 0.043:w * 0.041
                  ),
                ),
              ],
            ),
             SizedBox(height:  h * 0.002),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal:  w * 0.015,
              ),
              child: Container(
                width: w * 0.065,
                height:  h * 0.0025,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}