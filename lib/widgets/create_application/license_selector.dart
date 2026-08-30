import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/application_controller.dart';

class LicenseSelector extends StatelessWidget {
  final Size size;
  const LicenseSelector({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: DropdownButtonFormField(
          isExpanded: true,
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          value: controller.licenseTypeId.value == 0
              ? null
              : controller.licenseTypeId.value,
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
            hintText: "select_license_type".tr,
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
          items: controller.licenses.map<DropdownMenuItem>((e) {
            return DropdownMenuItem(value: e["id"], child: Text(e["name"]));
          }).toList(),
          onChanged: (v) {
            controller.licenseTypeId.value = v;
          },
        ),
      ),
    );
  }
}
