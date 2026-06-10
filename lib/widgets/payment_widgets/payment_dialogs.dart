import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/home_page/home_controller.dart';
import 'package:project_2/modules/payment/payment_controller.dart';
import '../../../app_theme/app_colors.dart';

class PaymentDialogs {
  static void showCheckoutDialog(
    BuildContext screenContext,
    PaymentController controller,
    VoidCallback onShowVerify,
  ) {
    showDialog(
      context: screenContext,
      barrierDismissible: false,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('إتمام الدفع'),
          content: const Text(
            'سيتم فتح صفحة الدفع الآمنة. بعد إتمام الدفع، اضغط على "تم التحقق" للتحقق من حالة الدفع.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                controller.launchCheckout();
                Future.delayed(const Duration(seconds: 3), () {
                  if (screenContext.mounted) {
                    onShowVerify();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('متابعة'),
            ),
          ],
        ),
      ),
    );
  }

  static void showVerifyDialog(
    BuildContext screenContext,
    int applicationId,
    PaymentController controller,
    VoidCallback onVerify,
  ) {
    showDialog(
      context: screenContext,
      barrierDismissible: false,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('التحقق من الدفع'),
          content: const Text(
            'هل قمت بإتمام عملية الدفع في صفحة Stripe؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Text('لم أكمل'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                controller.startStatusCheck(applicationId, controller.paymentId.value);
                controller.checkPaymentStatus(applicationId, controller.paymentId.value);
                Get.back();
                onVerify();
                final homeController = Get.find<HomeController>();
                homeController.getCurrentApplication();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('تم التحقق'),
            ),
          ],
        ),
      ),
    );
  }
}
