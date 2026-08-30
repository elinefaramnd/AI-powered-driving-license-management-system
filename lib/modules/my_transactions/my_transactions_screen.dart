import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/my_transactions/transaction_details_screen.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/my_transaction_widget/transaction_card.dart';
import '../../widgets/my_transaction_widget/transactions_empty.dart';
import '../../widgets/my_transaction_widget/transactions_header.dart';
import '../../widgets/my_transaction_widget/transactions_tabs.dart';
import 'my_transactions_controller.dart';

class MyTransactionsScreen extends StatefulWidget {
  const MyTransactionsScreen({super.key});

  @override
  State<MyTransactionsScreen> createState() => _MyTransactionsScreenState();
}

class _MyTransactionsScreenState extends State<MyTransactionsScreen> {
  late final MyTransactionsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(MyTransactionsController());
  }

  @override
  void dispose() {
    Get.delete<MyTransactionsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7F7),
      appBar: CustomAppBar(title: 'my_transactions'.tr),
      body: Column(
        children: [
          const TransactionsHeader(),

          SizedBox(height: w * .015),

          TransactionsTabs(controller: controller),

          SizedBox(height: w * .025),

          Expanded(child: Obx(() => _buildTransactionsContent())),
        ],
      ),
    );
  }

  Widget _buildTransactionsContent() {
    final w = MediaQuery.of(context).size.width;

    if (controller.currentLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    if (controller.currentError.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(w * .06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.redAccent,
                size: w * .14,
              ),
              SizedBox(height: w * .035),
              Text(
                controller.currentError,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: w * .035, color: Colors.grey[700]),
              ),
              SizedBox(height: w * .04),
              ElevatedButton.icon(
                onPressed: controller.refreshCurrentTab,
                icon: const Icon(Icons.refresh),
                label: Text('retry'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (controller.currentTransactions.isEmpty) {
      return TransactionsEmpty(onRefresh: controller.refreshCurrentTab);
    }

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: controller.refreshCurrentTab,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(w * .045, w * .015, w * .045, w * .06),
        itemCount: controller.currentTransactions.length,
        itemBuilder: (context, index) {
          final transaction = controller.currentTransactions[index];

          return TransactionCard(
            transaction: transaction,
            onTap: () {
              Get.to(
                () => TransactionDetailsScreen(transactionId: transaction.id),
              );
            },
          );
        },
      ),
    );
  }
}
