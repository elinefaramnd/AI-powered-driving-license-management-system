import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../app_theme/app_colors.dart';
import 'order_card.dart';
import 'orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  final controller = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text("طلباتي", style: TextStyle(color: AppColors.primaryColor)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    Icons.folder_open,

                    size: 35,

                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "لا يوجد طلبات",

                  style: TextStyle(
                    fontSize: 22,

                    fontWeight: FontWeight.bold,

                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "لا توجد طلبات بعد، أنشئ طلبك الأول للبدء",

                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.orders.length,
          itemBuilder: (_, i) {
            final order = controller.orders[i];
            return OrderCard(order: order);
          },
        );
      }),
    );
  }
}
