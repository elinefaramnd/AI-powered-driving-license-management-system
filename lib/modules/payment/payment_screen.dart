import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    controller.getApplicationFee(applicationId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title:"payment_fees".tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * .035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OrderInfoCard(
                      applicationId: applicationId,
                      status: homeController.currentApplicationStatus.value,
                    ),
                     SizedBox(height: w * .035),
                    AmountCard(amount: controller.feeAmount.value),
                     SizedBox(height: w * .09),
                    Text(
                      "choose_payment_method".tr,
                      style: TextStyle(
                        fontSize: w * .045,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                     SizedBox(height: w * .035),
                    const PaymentMethodCard(),
                     SizedBox(height: w * .04),
                    const SecurityNote(),
                     SizedBox(height: w * .035),
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
                      () => Get.snackbar("verifying".tr,
                        "verifying_payment_status".tr,),
                    ),
                  );
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
