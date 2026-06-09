import 'package:flutter/material.dart';

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
        return 'تم الدفع بنجاح!';
      case 'failed':
        return 'فشل الدفع. يرجى المحاولة مرة أخرى.';
      case 'cancelled':
        return 'تم إلغاء الدفع.';
      case 'pending':
        return 'جاري معالجة الدفع...';
      default:
        return 'حالة الدفع: $status';
    }
  }
}
