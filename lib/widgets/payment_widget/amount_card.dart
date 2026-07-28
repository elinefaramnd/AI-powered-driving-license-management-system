import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class AmountCard extends StatelessWidget {
  final double amount;

  const AmountCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: w * .07, horizontal: w * .06),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(w*.035),
      ),
      child: Column(
        children: [
          Text(
            "total_amount_due".tr,
            style: TextStyle(
              fontSize: w * .042,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
           SizedBox(height: w*.031),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                amount.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: w * .065,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
               SizedBox(width: w*.028),
              Text(
                "currency".tr,
                style: TextStyle(
                  fontSize: w * .045,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
