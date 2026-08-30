import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../app_theme/app_colors.dart';

class FinePaymentStatus extends StatelessWidget {
  final String status;

  const FinePaymentStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * .04),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(.08),
        borderRadius: BorderRadius.circular(w * .035),
      ),
      child: Row(
        children: [
          Icon(Icons.sync, color: AppColors.gold, size: w * .06),

          SizedBox(width: w * .03),

          Expanded(
            child: Text(
              '${"payment_status".tr}: '
              '${_statusLabel(status)}',
              style: TextStyle(fontSize: w * .036, fontWeight: FontWeight.w600),
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
