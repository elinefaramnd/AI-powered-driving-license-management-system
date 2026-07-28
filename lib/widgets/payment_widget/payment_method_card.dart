import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final w=size.width;
    final isRtl=Directionality.of(context)==TextDirection.rtl;
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: w*.04, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w*.04),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: w*.1,
            height: w*.1,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.credit_card,
              color: AppColors.darkGreen,
              size: w*.06,
            ),
          ),
           SizedBox(width: w*.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            "electronic_payment".tr,
                  style: TextStyle(
                    fontSize: w*.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "stripe_payment".tr,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: w*.04,
            ),
          ),
        ],
      ),
    );
  }
}
