import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../modules/home_page/home_controller.dart';
import '../../modules/home_page/order_card_controller.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final orderController = Get.put(OrderCardController());
    final size = MediaQuery.of(context).size;
    final canUse = controller.profileStatus.value == "approved";
    final profileStatus = controller.profileStatus.value;
    return Container(
      height: size.height * 0.39,
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "طلبك الحالي",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.039,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.hasApplication.value
                        ? controller.currentService.value
                        : "لا يوجد طلبات حالياً",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.033,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Obx(
                  () => Text(
                    controller.hasApplication.value
                        ? controller.currentApplicationNumber.value
                        : "أنشأ أول طلب للبدء",
                    style: TextStyle(fontSize: size.width * 0.032),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Divider(),
                Text(
                  "الحالة الحالية",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.039,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.hasApplication.value
                        ? controller.currentApplicationStatus.value
                        : "-",
                    style: TextStyle(
                      color: const Color(0xffB08D57),
                      fontSize: size.width * 0.03,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.008),

                Obx(
                  () => orderController.buildStep(
                    width: size.width,
                    height: size.height,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.01,
            left: 0,
            child: Image.asset(
              "assets/images/car.png",
              width: size.width * 0.49,
              height: size.height * 0.25,
            ),
          ),
        ],
      ),
    );
  }
}
