import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/document_card_widget.dart';
import '../../../widgets/info_card_widget.dart';
import 'order_details_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("تفاصيل الطلب"),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final order = controller.order.value!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InfoCardWidget(
                value: order.application_number,
                title: "رقم الطلب",
              ),
              InfoCardWidget(title: "نوع الرخصة", value: order.licenseType),
              InfoCardWidget(title: "نوع الخدمة", value: order.serviceType),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "المستندات المرفقة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (order.documents.isEmpty)
                      Column(
                        children: [
                          SizedBox(height: 18),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              color: const Color(0xffF8F9FA),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.upload_file_outlined,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  "لا يوجد مستندات مرفوعة",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "قم برفع الوثائق المطلوبة ليتم متابعة الطلب",

                                  style: TextStyle(
                                    color: Colors.grey.shade600,

                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      ...order.documents.map(
                        (doc) => DocumentItemWidget(document: doc),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
