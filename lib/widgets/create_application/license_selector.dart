import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/create_application/application_controller.dart';
class LicenseSelector extends StatelessWidget {
  final Size size;
  const LicenseSelector({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField(
          isExpanded: true,
          alignment: Alignment.centerRight,
          value: controller.licenseTypeId.value == 0
              ? null
              : controller.licenseTypeId.value,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "اختر نوع الرخصة",
          ),
          icon: Transform.flip(
            flipX: true,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
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
