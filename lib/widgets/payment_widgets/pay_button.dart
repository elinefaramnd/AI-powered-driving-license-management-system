import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/payment/payment_screen.dart';
import '../../../app_theme/app_colors.dart';


class PayButton extends StatelessWidget {
  final int applicationId;
  final double? amount;
  final bool isEnabled;

  const PayButton({
    super.key,
    required this.applicationId,
    this.amount,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isEnabled
            ? () {
                Get.to(() => PaymentScreen(applicationId: applicationId));
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey,
        ),
        icon: const Icon(Icons.payment),
        label: Text(
          amount != null
              ? 'دفع ${amount!.toStringAsFixed(0)} ل.س'
              : 'الدفع الآن',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
