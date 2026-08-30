import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/application_controller.dart';

class OwnedLicenseSelector extends StatelessWidget {
  final Size size;
  const OwnedLicenseSelector({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: DropdownButtonFormField<int>(
          isExpanded: true,
          value: controller.relatedLicenseId.value == 0
              ? null
              : controller.relatedLicenseId.value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * .025),
              borderSide: BorderSide(
                color: AppColors.gold.withOpacity(.45),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * .025),
              borderSide: BorderSide(
                color: AppColors.gold.withOpacity(.45),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * .025),
              borderSide: BorderSide(
                color: AppColors.gold.withOpacity(.45),
                width: 1,
              ),
            ),
            hintText: "select_license".tr,
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: size.width * .025),
                Icon(
                  Icons.badge_outlined,
                  color: AppColors.gold,
                  size: size.width * .055,
                ),
                SizedBox(width: size.width * .02),
                Container(
                  width: 1,
                  height: size.height * .035,
                  color: AppColors.gold.withOpacity(.45),
                ),
                SizedBox(width: size.width * .02),
              ],
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: controller.ownedLicenses.map<DropdownMenuItem<int>>((e) {
            return DropdownMenuItem<int>(
              value: e["id"] as int,
              child: Text(
                "${e["license_type"]["name"]} - ${e["license_number"]}",
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.relatedLicenseId.value = value;
            }
          },
        ),
      ),
    );
  }
}
