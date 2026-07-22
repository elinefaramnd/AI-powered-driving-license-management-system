import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'custom_divider.dart';
import 'order_info_row.dart';

class OrderDetailsInfoCard extends StatelessWidget {
  final dynamic order;

  const OrderDetailsInfoCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.055),
      ),
      child: Column(
        children: [
          OrderInfoRow(
            title: "application_number".tr,
            value: order.application_number,
            icon: Icons.assignment_outlined,
          ),

          const CustomDivider(),

          OrderInfoRow(
            title: "license_type".tr,
            value: order.licenseType,
            icon: Icons.badge_outlined,
          ),

          const CustomDivider(),

          OrderInfoRow(
            title: "service_type".tr,
            value: order.serviceType,
            icon: Icons.description_outlined,
          ),
        ],
      ),
    );
  }
}