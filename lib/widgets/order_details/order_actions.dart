import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/payment/payment_screen.dart';

class OrderActions extends StatelessWidget {
  final String status;
  final int applicationId;

  const OrderActions({
    super.key,
    required this.status,
    required this.applicationId,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    if (status != 'payment_pending') {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      height: h * 0.057,
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => PaymentScreen(applicationId: applicationId));
        },
        icon: const Icon(Icons.payment, color: Colors.white),
        label: const Text(
          "دفع الرسوم",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}