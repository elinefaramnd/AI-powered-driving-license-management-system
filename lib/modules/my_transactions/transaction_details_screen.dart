import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../widgets/my_transaction_widget/details/transaction_details_card.dart';
import 'transaction_details_controller.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final int transactionId;

  const TransactionDetailsScreen({
    super.key,
    required this.transactionId,
  });

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}
class _TransactionDetailsScreenState
    extends State<TransactionDetailsScreen> {
  late final TransactionDetailsController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(
      TransactionDetailsController(
        transactionId: widget.transactionId,
      ),
      tag: widget.transactionId.toString(),
    );
  }
  @override
  void dispose() {
    Get.delete<TransactionDetailsController>(
      tag: widget.transactionId.toString(),
    );
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F7),
      appBar: CustomAppBar(
        title: 'transaction_details'.tr,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (controller.transaction.value == null) {
          return Center(
            child: Text(
              controller.error.value.isNotEmpty
                  ? controller.error.value
                  : 'something_went_wrong'.tr,
            ),
          );
        }

        return TransactionDetailsCard(
          data: controller.transaction.value!,
        );
      }),
    );
  }
}