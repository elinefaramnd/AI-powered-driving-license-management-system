import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/notification/notifications_controller.dart';
import 'notification_tab_item.dart';

class NotificationTabs extends StatelessWidget {
  final NotificationsController controller;

  const NotificationTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isArabic = Get.locale?.languageCode == "ar";

    return Container(
      color: const Color(0xffF7F7F4),
      padding: EdgeInsets.symmetric(horizontal: size.width * .04, vertical: 10),
      child: Obx(
        () => Align(
          alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NotificationTabItem(
                title: "all".tr,
                selected: controller.selectedTab.value == 0,
                onTap: () {
                  controller.changeTab(0);
                },
              ),
              SizedBox(width: size.width * .025),

              NotificationTabItem(
                title: "unread".tr,
                selected: controller.selectedTab.value == 1,
                count: controller.unreadCount.value,
                onTap: () {
                  controller.changeTab(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
