import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/application_controller.dart';

class SubmitButton extends StatelessWidget {
  final Size size;
  const SubmitButton({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: size.height * .07,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: controller.loading.value ? null : controller.createDraft,
          child: controller.loading.value
              ? const CircularProgressIndicator()
              : Text(
                  "التالي",
                  style: TextStyle(
                    fontSize: size.width * .045,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
