import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../widgets/order_details/document_card_widget.dart';
import '../../../widgets/order_details/documents_section_header.dart';
import '../../../widgets/order_details/empty_documents_widget.dart';
import '../../../widgets/order_details/order_actions.dart';
import '../../../widgets/order_details/order_details_info_card.dart';
import '../../../widgets/order_details/order_status_card.dart';
import 'order_details_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final controller = Get.put(OrderDetailsController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("تفاصيل الطلب"),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final order = controller.order.value!;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: h * 0.01,
            horizontal: w * 0.04,
          ),
          child: Column(
            children: [
              const OrderStatusCard(),
              SizedBox(height: h * 0.0132),
              OrderDetailsInfoCard(
                order: order,
              ),
              SizedBox(height: h * 0.014),
              const DocumentsSectionHeader(),
              SizedBox(height: h * 0.01),
              if (order.documents.isEmpty)
                const EmptyDocumentsWidget()
              else
                ...order.documents.map(
                      (doc) => DocumentItemWidget(
                    document: doc,
                  ),
                ),
              SizedBox(height: h * 0.025),
              const OrderActions(),
            ],
          ),
        );
      }),
    );
  }
}