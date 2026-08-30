import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';
import '../../modules/home_page/order_card_controller.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});
  @override
  Widget build(BuildContext context) {

    final isArabic = Get.locale?.languageCode == "ar";
    final controller = Get.find<HomeController>();
    final orderController = Get.find<OrderCardController>();
    final size = MediaQuery.of(context).size;
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
            "current_request".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.locale?.languageCode == "ar" ?size.width * .039:size.width * .036,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.hasApplication.value
                        ? controller.currentService.value
                        : "no_current_requests".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.03,
                      color: Colors.grey
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Obx(
                  () => Text(
                    controller.hasApplication.value
                        ? controller.currentApplicationNumber.value
                        : "create_first_request".tr,
                    style: TextStyle(fontSize: size.width * 0.03),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Divider(),
                Text(
                  "current_status".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.locale?.languageCode == "ar" ?size.width * .039:size.width * .036,
                  ),
                ),
                Obx(
                  () => Text(
                   controller.getCurrentStatusText(),
                    style: TextStyle(
                      color: const Color(0xffB08D57),
                      fontSize: size.width * 0.03,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.008),

                Obx(
                      () {
                    final status = controller.currentApplicationStatus.value;

                    return orderController.buildStep(
                      width: size.width,
                      height: size.height,
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.01,
            left: isArabic ? 0 : null,
            right: isArabic ? null : 0,
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
