import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';

class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(
        w * .045,
        w * .035,
        w * .045,
        w * .02,
      ),
      padding: EdgeInsets.all(w * .05),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(w * .055),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: w * .14,
            height: w * .14,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: w * .07,
            ),
          ),

          SizedBox(width: w * .04),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my_transactions'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * .052,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: w * .012),

                Text(
                  'my_transactions_subtitle'.tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.78),
                    fontSize: w * .032,
                    height: 1.3,
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