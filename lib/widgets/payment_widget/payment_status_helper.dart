import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PaymentStatusHelper {
  static Color getColor(String status) {
    switch (status) {
      case 'completed':
      case 'paid':
        return Colors.green;
      case 'failed':
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static IconData getIcon(String status) {
    switch (status) {
      case 'completed':
      case 'paid':
        return Icons.check_circle;
      case 'failed':
      case 'cancelled':
        return Icons.error;
      case 'pending':
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }

  static String getText(String status) {
    switch (status) {
      case 'completed':
      case 'paid':
      return "payment_success".tr;
      case 'failed':
        return "payment_failed".tr;
      case 'cancelled':
        return "payment_cancelled".tr;
      case 'pending':
        return "payment_processing".tr;
      default:
        return "payment_status".trParams({
          "status": status,
        });
    }
  }
}
