import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../app_theme/app_colors.dart';
import '../modules/home_page/home_controller.dart';

class ServicesGridWidget extends StatelessWidget {
  const ServicesGridWidget({super.key});
  IconData getIcon(String code) {
    switch (code) {
      case "new_license":
        return Icons.note_add_outlined;

      case "renew_license":
        return Icons.autorenew;

      case "lost_replacement":
        return Icons.sync;

      case "damaged_replacement":
        return Icons.description_outlined;

      case "license_unblock":
        return Icons.lock_open_outlined;

      default:
        return Icons.grid_view;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: Icon(
                Icons.grid_view,
                color: AppColors.primaryColor,
                size: w * 0.05,
              ),
            ),
            Text(
              "الخدمات المرورية",
              style: TextStyle(
                fontSize: w * 0.043,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: h * 0.005),
        SizedBox(
          height: h * 0.20,
          child: Stack(
            children: [
              Obx(() {
                if (controller.loadingServices.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.services.length,
                  separatorBuilder: (_, __) => SizedBox(width: w * 0.017),
                  itemBuilder: (_, i) {
                    final service = controller.services[i];
                    return Container(
                      width: w * 0.36,
                      padding: EdgeInsets.all(w * 0.035),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.045),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.04,
                            width: h * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green.withOpacity(0.2),
                            ),
                            child: Icon(
                              getIcon(service["code"]),
                              color: AppColors.darkGreen,
                              size: w * 0.07,
                            ),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            service["name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.035,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            service["description"] ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: w * 0.028,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
              Positioned(
                left: w * 0.01,
                top: 0,
                bottom: -w * 0.15,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: w * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
