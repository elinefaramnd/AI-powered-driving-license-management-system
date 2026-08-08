import 'package:flutter/material.dart';
import '../../../app_theme/app_colors.dart';

class OrderStatusCard extends StatelessWidget {
  final String status;

  const OrderStatusCard({super.key, required this.status});

  String get title {
    switch (status) {
      case 'draft':
        return 'طلب جديد';
      case 'pending_review':
        return 'المستندات مكتملة';
      case 'payment_pending':
        return 'بانتظار الدفع';
      case 'approved':
        return 'تم القبول';
      case 'license_issued':
        return 'تم إصدار الرخصة';
      default:
        return 'حالة الطلب';
    }
  }

  String get subtitle {
    switch (status) {
      case 'draft':
        return 'تم إنشاء الطلب، يرجى رفع المستندات المطلوبة';
      case 'pending_review':
        return 'تم استلام جميع المستندات بنجاح\nوجارٍ مراجعة طلبك من قبل المختصين';
      case 'payment_pending':
        return 'تم قبول المستندات، يرجى دفع الرسوم لإكمال الطلب';
      case 'approved':
        return 'تم الدفع بنجاح، جارٍ إصدار الرخصة البديلة';
      case 'license_issued':
        return 'تم إصدار رخصة بديلة بنجاح';
      default:
        return 'جارٍ معالجة طلبك';
    }
  }

  String get badge {
    switch (status) {
      case 'draft':
        return 'مسودة';
      case 'pending_review':
        return 'قيد المراجعة';
      case 'payment_pending':
        return 'بانتظار الدفع';
      case 'approved':
        return 'مقبول';
      case 'license_issued':
        return 'تم الإصدار';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Container(
      width: double.infinity,
      height: h * 0.17,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
        vertical: h * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.025),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: w * 0.029,
                  ),
                ),
                SizedBox(height: h * 0.019),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.013,
                    vertical: h * 0.0012,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.075),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        badge,
                        style: TextStyle(
                          color: Color(0xff1B5E20),
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.035,
                        ),
                      ),
                      SizedBox(width: w * 0.013),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: w * 0.05,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: w * 0.038),
          Image.asset(
            "assets/images/download1.png",
            width: w * 0.32,
            height: w * 0.32,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
