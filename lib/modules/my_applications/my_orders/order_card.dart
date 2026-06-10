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
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.045),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:  EdgeInsets.symmetric(
                  horizontal: size.width * 0.025,
                  vertical: size.height * 0.006,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: Text(
                  getStatusText(),
                  style: TextStyle(color: getStatusColor(), fontSize: size.width * 0.03,),
                ),
              ),
              Column(
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
            ],
          ),
          SizedBox(height: size.height * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.application_number.toString()),
              const Text("رقم الطلب", style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: size.height * 0.015),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff054239),
              minimumSize: Size(double.infinity, size.height * 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
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
