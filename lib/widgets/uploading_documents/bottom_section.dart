import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';

class BottomSection extends StatelessWidget {
  final dynamic controller;
  const BottomSection({required this.controller});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Padding(
      padding: EdgeInsets.all(w * 0.05),
      child: controller.submitted.value
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: h * 0.065,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
              ),
              child: const Text(
                "تم إرسال الطلب",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: h * 0.012),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                if (Get.isRegistered<HomeController>()) {
                  await Get.find<HomeController>()
                      .getCurrentApplication();
                }
                Get.offAllNamed('/home');
              },
              icon: Icon(
                Icons.home_outlined,
                color: AppColors.primaryColor,
              ),
              label: Text(
                "العودة للرئيسية",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      )
          : SizedBox(
        width: double.infinity,
        height: h * 0.056,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.canSubmit
                ? AppColors.primaryColor
                : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.025),
            ),
          ),
          onPressed: controller.canSubmit
              ? controller.submitDocuments
              : null,
          child: const Text(
            "متابعة",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}