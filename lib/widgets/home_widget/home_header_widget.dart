import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';
import '../../modules/notification/notifications_controller.dart';

class HomeHeaderWidget extends StatelessWidget {
  final HomeController controller;
  const HomeHeaderWidget({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final notificationsController = Get.put(NotificationsController());
    final isArabic = Get.locale?.languageCode == "ar";
    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;
    return Container(
      color: Colors.transparent,

      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.005,
      ),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Obx(() {
            final canUse = controller.canUseServices;
            final profileStatus = controller.profileStatus.value;
            return IconButton(
              onPressed: canUse
                  ? controller.openDrawer
                  : () {
                      AppSnackbar.show(
                        "warning".tr,
                        profileStatus == "pending_review"
                            ? "account_under_review".tr
                            : profileStatus == "rejected"
                            ? "profile_rejected".tr
                            : "complete_profile_first".tr,
                      );
                    },
              icon: Icon(
                Icons.menu,
                color: canUse ? Colors.white : Colors.grey,
                size: 24 * scale,
              ),
            );
          }),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed("/notifications");
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                icon: Icon(
                  Icons.notifications_none,
                  size: 28 * scale,
                  color: Colors.white,
                ),
              ),
              Obx(() {
                final count = notificationsController.unreadCount.value;
                if (count == 0) {
                  return const SizedBox();
                }
                return Positioned(
                  right: 6,
                  top: 7,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        fontSize: 10 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const Spacer(),
          Row(
            textDirection: isArabic ? TextDirection.ltr : TextDirection.rtl,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * 0.10,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                    width: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: size.width * 0.025),
              Column(
                children: [
                  Text(
                    "app_name_ar".tr,
                    style: TextStyle(
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
            ],
          ),
        ],
      ),
    );
  }
}
