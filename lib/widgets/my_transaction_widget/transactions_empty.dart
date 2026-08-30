import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';

class TransactionsEmpty extends StatelessWidget {
  final VoidCallback onRefresh;

  const TransactionsEmpty({
    super.key,
    required this.onRefresh,
  });
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(w * .08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w * .25,
              height: w * .25,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primaryColor,
                size: w * .12,
              ),
            ),

            SizedBox(height: w * .05),

            Text(
              'no_transactions'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * .045,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: w * .02),

            Text(
              'no_transactions_description'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: w * .033,
                height: 1.4,
              ),
            ),

            SizedBox(height: w * .05),

            OutlinedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: Text('refresh'.tr),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(
                  color: AppColors.primaryColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * .03),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}