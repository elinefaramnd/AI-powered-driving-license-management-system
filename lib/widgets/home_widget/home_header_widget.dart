import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';

class HomeHeaderWidget extends StatelessWidget {
  final HomeController controller;

  const HomeHeaderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;

    return Container(
      color: Colors.white,

      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.005,
      ),

      child: Row(
        children: [
          Obx(() {
            final canUse = controller.canUseServices;
            final profileStatus = controller.profileStatus.value;

            return IconButton(
              onPressed: canUse
                  ? controller.openDrawer
                  : () {
                AppSnackbar.show( "تنبيه",  profileStatus == "pending_review"
                ? "الحساب قيد المراجعة حالياً"
                    : profileStatus == "rejected"
                ? "تم رفض الملف، يرجى التعديل"
                    : "يرجى إكمال الملف الشخصي أولاً",);
              },
              icon: Icon(
                Icons.menu,
                color: canUse ? AppColors.primary : Colors.grey,
                size: 24 * scale,
              ),
            );
          }),

          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                size: 28 * scale,
              ),

              Positioned(
                right: 0,
                child: Obx(
                      () => Container(
                    padding: EdgeInsets.all(4 * scale),

                    decoration: const BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),

                    child: Text(
                      controller.notificationsCount.value.toString(),

                      style: TextStyle(
                        fontSize: 10 * scale,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    "سيرتك",
                    style: TextStyle(
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),

                  Text(
                    "S Y R T A K",
                    style: TextStyle(
                      fontSize: 10 * scale,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),

              SizedBox(width: size.width * 0.025),

              SizedBox(
                width: size.width * 0.10,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}