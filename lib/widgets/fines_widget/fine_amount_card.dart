import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class FineAmountCard extends StatelessWidget {
  final double amount;
  final String currency;
  final String status;

  const FineAmountCard({
    super.key,
    required this.amount,
    required this.currency,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * .055),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(w * .045),
      ),
      child: Column(
        children: [
          Text(
            "fine_amount".tr,
            style: TextStyle(color: Colors.white70, fontSize: w * .038),
          ),
          SizedBox(height: w * .02),
          Text(
            '${amount.toStringAsFixed(2)} $currency',
            style: TextStyle(
              color: Colors.white,
              fontSize: w * .075,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: w * .025),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * .035,
              vertical: w * .018,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(w * .05),
            ),
            child: Text(
              _statusLabel(status),
              style: TextStyle(
                color: Colors.white,
                fontSize: w * .033,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'paid':
      case 'completed':
        return "payment_completed".tr;

      case 'unpaid':
        return "unpaid".tr;

      case 'pending':
        return "payment_pending_status".tr;

      case 'processing':
        return "payment_processing_status".tr;

      case 'failed':
        return "payment_failed_status".tr;

      case 'cancelled':
        return "payment_cancelled_status".tr;

      default:
        return status;
    }
  }
}
