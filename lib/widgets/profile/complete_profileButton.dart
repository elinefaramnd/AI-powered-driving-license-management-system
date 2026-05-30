import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../modules/profile/complete_profile_controller.dart';
import '../app_button.dart';

class CompleteProfileButton extends StatelessWidget {
  const CompleteProfileButton({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();
    return Obx(
      () => AppButton(
        text: "",
        onPressed: controller.isLoading.value
            ? () {}
            : () {
          final storedName = GetStorage().read('name');
          print("storedName = $storedName");
          print("enteredName = ${controller.nameController.text.trim()}");
          if (controller.nameController.text.trim() != storedName) {
            controller.nameError.value = 'الاسم غير مطابق لاسم التسجيل';
            return;
          }

          controller.completeProfile();
        },
        child: controller.isLoading.value
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "حفظ و متابعة",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
