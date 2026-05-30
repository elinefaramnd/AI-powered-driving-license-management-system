import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});
  Color getStatusColor() {
    switch (order.status) {
      case "draft":
        return Colors.orange;
      case "pending_review":
        return Colors.blue;
      case "payment_pending":
        return Colors.purple;
      case "approved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getStatusText() {
    switch (order.status) {
      case "draft":
        return "مسودة";
      case "pending_review":
        return "قيد المراجعة";
      case "payment_pending":
        return "بانتظار الدفع";
      case "approved":
        return "مقبول";
      default:
        return order.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.serviceType,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.licenseType,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  getStatusText(),
                  style: TextStyle(color: getStatusColor(), fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.application_number.toString()),
              const Text("رقم الطلب", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff054239),
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Get.toNamed("/order_details", arguments: order);
            },
            child: const Text(
              "عرض التفاصيل",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
