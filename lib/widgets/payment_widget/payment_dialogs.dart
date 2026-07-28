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
  )
  {
    final isRtl = Get.locale?.languageCode == "ar";
    showDialog(
      context: screenContext,
      barrierDismissible: false,
      builder: (dialogContext) => Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text("payment_completion".tr,),
          content: Text(
            "payment_completion_message".tr,
          ),
          actions: [
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
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text("continue_payment".tr),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("cancel".tr),
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
    final isRtl = Get.locale?.languageCode == "ar";
    showDialog(
      context: screenContext,
      barrierDismissible: false,
      builder: (dialogContext) => Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text("verify_payment".tr),
          content: Text(
            "verify_payment_message".tr,
          ),
          actions: [
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
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text("verified".tr),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("not_completed".tr),
            ),
          ],
        ),
      ),
    );
  }
}
