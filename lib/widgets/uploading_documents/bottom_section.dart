import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
              child: Text(
                "application_submitted".tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: h * 0.012),
          SizedBox(
            width: double.infinity,
            child: Directionality(
              textDirection: Directionality.of(context),
              child: OutlinedButton.icon(
                onPressed: () async {
                  if (Get.isRegistered<HomeController>()) {
                    final home = Get.find<HomeController>();
              
                    await Future.wait([
                      home.getProfileStatus(),
                      home.getCurrentApplication(),
                    ]);
              
                  }
                  Get.offAllNamed('/home');
                },
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  "back_to_home".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
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
          child: Text(
            "continue".tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}