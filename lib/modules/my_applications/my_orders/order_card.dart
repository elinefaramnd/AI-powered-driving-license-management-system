import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:project_2/app_theme/app_colors.dart';

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
        return AppColors.primaryColor;
      default:
        return Colors.grey;
    }
  }

  String getStatusText() {
    switch (order.status) {
      case "draft":
        return "draft".tr;
      case "pending_review":
        return "pending_review".tr;
      case "payment_pending":
        return "payment_pending".tr;
      case "approved":
        return "approved".tr;
      default:
        return order.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
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
            ],
          ),
          SizedBox(height: size.height * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("application_number".tr, style: TextStyle(color: Colors.grey,
                fontSize: isRtl ? size.width * 0.039 : size.width * 0.035,)),
              Text(order.application_number.toString() ,style: TextStyle(fontSize: size.width * 0.035,),),
            ],
          ),
          SizedBox(height: size.height * 0.015),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: Size(double.infinity, size.height * 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
              ),
            ),
            onPressed: () {
              Get.toNamed("/order_details", arguments: order);
            },
            child: Text(
              "view_details".tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
