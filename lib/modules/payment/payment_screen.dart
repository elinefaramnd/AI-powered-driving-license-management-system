import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/payment_widget/amount_card.dart';
import '../../widgets/payment_widget/order_info_card.dart';
import '../../widgets/payment_widget/payment_bottom_bar.dart';
import '../../widgets/payment_widget/payment_dialogs.dart';
import '../../widgets/payment_widget/payment_method_card.dart';
import '../../widgets/payment_widget/payment_status_card.dart';
import '../../widgets/payment_widget/security_note.dart';
import '../home_page/home_controller.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  final int applicationId;

  PaymentScreen({super.key, required this.applicationId});

  final controller = Get.put(PaymentController());
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    controller.getApplicationFee(applicationId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('دفع الرسوم',style: TextStyle(fontWeight: FontWeight.bold),),
          // titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OrderInfoCard(
                        applicationId: applicationId,
                        status: homeController.currentApplicationStatus.value,
                      ),
                      const SizedBox(height: 16),
                      AmountCard(amount: controller.feeAmount.value),
                      const SizedBox(height: 24),
                      Text(
                        'اختر وسيلة الدفع',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const PaymentMethodCard(),
                      const SizedBox(height: 16),
                      const SecurityNote(),
                      const SizedBox(height: 12),
                      if (controller.paymentStatus.value.isNotEmpty)
                        PaymentStatusCard(status: controller.paymentStatus.value),
                    ],
                  ),
                ),
              ),
              PaymentBottomBar(
                isLoading: controller.isCreatingPayment.value,
                onPressed: () async {
                  final success = await controller.createPayment(applicationId);
                  if (success) {
                    PaymentDialogs.showCheckoutDialog(
                      context,
                      controller,
                      () => PaymentDialogs.showVerifyDialog(
                        context,
                        applicationId,
                        controller,
                        () => Get.snackbar('جاري التحقق', 'جاري التحقق من حالة الدفع...'),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
