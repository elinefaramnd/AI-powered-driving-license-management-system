import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            border: InputBorder.none,
            hintText: "select_license_type".tr,
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
