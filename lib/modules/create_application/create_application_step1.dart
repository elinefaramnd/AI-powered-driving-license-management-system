import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/create_application/application_header.dart';
import '../../widgets/create_application/owned_license_selector.dart';
import '../../widgets/create_application/service_selector.dart';
import '../../widgets/create_application/license_selector.dart';
import '../../widgets/create_application/submit_button.dart';
import '../../widgets/custom_app_bar.dart';
import 'application_controller.dart';

class CreateApplicationStep1 extends StatelessWidget {
  CreateApplicationStep1({super.key});
  final controller = Get.put(ApplicationController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final licenseId = Get.arguments as int?;
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F4),
      appBar: CustomAppBar(title: "new_license_request_title".tr),
      body: Obx(() {
        if (controller.pageLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(size.width * .05),
          child: Container(
            padding: EdgeInsets.all(size.width * .05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ApplicationHeader(size: size),
                SizedBox(height: size.height * .015),
                Divider(
                  color: AppColors.gold.withOpacity(.55),
                  thickness: .7,
                  height: 1,
                ),
                SizedBox(height: size.height * .015),
                Align(
                  alignment: Directionality.of(context) == TextDirection.rtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: size.height * .025,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: size.width * .025),
                      Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.gold,
                        size: size.width * .055,
                      ),
                      SizedBox(width: size.width * .018),
                      Text(
                        "service_type".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .042,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .015),
                ServiceSelector(size: size),
                SizedBox(height: size.height * .015),
                Align(
                  alignment: Directionality.of(context) == TextDirection.rtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: size.height * .025,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: size.width * .025),
                      Icon(
                        Icons.badge_outlined,
                        color: AppColors.gold,
                        size: size.width * .055,
                      ),
                      SizedBox(width: size.width * .018),
                      Text(
                        "license_type".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .042,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .02),
                Obx(() {
                  final service = controller.services.firstWhereOrNull(
                    (e) => e["id"] == controller.serviceTypeId.value,
                  );
                  final code = service?["code"];
                  if (code == "lost_replacement" ||
                      code == "damaged_replacement" ||
                      code == "renew_license" ||
                      code == "license_unblock") {
                    return OwnedLicenseSelector(size: size);
                  }
                  return LicenseSelector(size: size);
                }),
                const SizedBox(height: 28),
                SubmitButton(size: size),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    "all_data_secure".tr,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}