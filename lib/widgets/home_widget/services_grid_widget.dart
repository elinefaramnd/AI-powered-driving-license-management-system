import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/application_controller.dart';
import '../../modules/create_application/create_application_step1.dart';
import '../../modules/home_page/home_controller.dart';
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
              "traffic_services".tr,
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
          height: h * 0.23,
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
                    final imagePath = _getServiceImage(service["code"]);
                    return GestureDetector(
                      onTap: () {
                        final applicationController =
                        Get.isRegistered<ApplicationController>()
                            ? Get.find<ApplicationController>()
                            : Get.put(ApplicationController());

                        applicationController.serviceTypeId.value = service["id"];

                        Get.to(
                              () => CreateApplicationStep1(),
                        );
                      },
                      child: Container(
                        width: w * 0.36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.035),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(w * 0.035),
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.11,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: h * 0.005,
                                    left: w * 0.015,
                                    right: w * 0.015,
                                  ),
                                  child: Image.asset(
                                    imagePath,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.018,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      service["name"] ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.034,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.002),
                                    Text(
                                      service["description"] ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: w * 0.026,
                                        height: 1.15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Get.locale?.languageCode == "ar"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: w * 0.018,
                                    bottom: h * 0.008,
                                  ),
                                  child: Container(
                                    width: w * 0.075,
                                    height: w * 0.075,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkGreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: w * 0.032,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              Positioned(
                left: Get.locale?.languageCode == "ar" ? w * 0.01 : null,
                right: Get.locale?.languageCode == "en" ? w * 0.01 : null,
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
String _getServiceImage(String code) {
  switch (code) {
    case "new_license":
      return "assets/images/issuing_a_license.png";
    case "renew_license":
      return "assets/images/license_renewal.png";
    case "lost_replacement":
      return "assets/images/replacement.png";
    case "damaged_replacement":
      return "assets/images/damaged_replacement.png";
    case "license_unblock":
      return "assets/images/unblockpng.png";
    default:
      return "assets/images/services/new_license.png";
  }
}
