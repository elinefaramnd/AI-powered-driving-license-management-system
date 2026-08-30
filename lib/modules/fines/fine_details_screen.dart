import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/fines_widget/fine_amount_card.dart';
import '../../widgets/fines_widget/fine_info_card.dart';
import '../../widgets/fines_widget/fine_paid_success_card.dart';
import '../../widgets/fines_widget/fine_pay_button.dart';
import '../../widgets/fines_widget/fine_payment_status.dart';
import 'fine_details_controller.dart';

class FineDetailsScreen extends StatefulWidget {
  final int fineId;

  const FineDetailsScreen({
    super.key,
    required this.fineId,
  });

  @override
  State<FineDetailsScreen> createState() =>
      _FineDetailsScreenState();
}

class _FineDetailsScreenState
    extends State<FineDetailsScreen> {
  late final FineDetailsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      FineDetailsController(),
      tag: widget.fineId.toString(),
    );

    controller.getFine(widget.fineId);
  }

  @override
  void dispose() {
    Get.delete<FineDetailsController>(
      tag: widget.fineId.toString(),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: CustomAppBar(
        title: "fine_details".tr,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        final fine = controller.fine.value;

        if (fine == null) {
          return Center(
            child: Text("no_fines".tr),
          );
        }

        final isPaid =
            fine.status == 'paid' ||
                fine.status == 'completed';

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * .045),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    FineAmountCard(
                      amount: fine.amount,
                      currency: fine.currency,
                      status: fine.status,
                    ),

                    if (isPaid) ...[
                      SizedBox(height: h * .02),
                      const FinePaidSuccessCard(),
                    ],

                    SizedBox(height: h * .025),

                    FineInfoCard(
                      fine: fine,
                    ),

                    SizedBox(height: h * .025),

                    if (controller
                        .paymentStatus
                        .value
                        .isNotEmpty)
                      FinePaymentStatus(
                        status:
                        controller.paymentStatus.value,
                      ),
                  ],
                ),
              ),
            ),

            if (fine.isPayable && !isPaid)
              FinePayButton(
                controller: controller,
                amount: fine.amount,
                currency: fine.currency,
              ),
          ],
        );
      }),
    );
  }
}