

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../app_theme/app_colors.dart';
import '../modules/home_page/home_controller.dart';

class BottomSection extends StatelessWidget {
  final dynamic controller;

  const BottomSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: controller.submitted.value
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
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
          const SizedBox(height: 10),
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
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.canSubmit
                ? AppColors.primaryColor
                : Colors.grey,
          ),
          onPressed: controller.canSubmit
              ? controller.submitDocuments
              : null,
          child: const Text(
            "تقديم الطلب",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}