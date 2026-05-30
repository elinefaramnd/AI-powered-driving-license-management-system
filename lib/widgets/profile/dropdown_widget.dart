import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/profile/complete_profile_controller.dart';

class GovernorateDropdown extends StatelessWidget {
  const GovernorateDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();
    return Obx(
      () => DropdownSearch<String>(
        items: (filter, loadProps) => controller.provinces,
        selectedItem: controller.selectedGovernorate.value,
        popupProps: const PopupProps.menu(showSearchBox: true),
        onSelected: (value) {
          controller.selectedGovernorate.value = value ?? '';
          controller.governorateController.text = value ?? '';
        },
      ),
    );
  }
}
