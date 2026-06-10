import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/fines/fines_controller.dart';

class FinesSummaryCard extends GetView<FinesController> {
  const FinesSummaryCard({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .20,
      padding: EdgeInsets.all(size.width * .05),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(size.width * .03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "إجمالي الغرامات الغير مدفوعة",
            style: TextStyle(
              color: Colors.white70,
              fontSize: size.width * .045,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "ل.س",
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: size.width * .05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: size.width * .01),
              Text(
                controller.totalAmount.toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * .06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .04,
              vertical: size.height * .01,
            ),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "عدد المخالفات: ${controller.totalCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * .04,
                  ),
                ),
                SizedBox(width: size.width * .02),
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.gold,
                  size: size.width * .06,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
