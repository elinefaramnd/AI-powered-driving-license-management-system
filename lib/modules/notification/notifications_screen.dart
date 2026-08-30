import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/notification_widgets/notification_card.dart';
import '../../widgets/notification_widgets/notification_tabs.dart';
import 'notifications_controller.dart';
class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final controller = Get.put(NotificationsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isArabic = Get.locale?.languageCode == "ar";
    return Directionality(
      textDirection:
      isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F4),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "notifications".tr,
            style: TextStyle(
              color: AppColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: size.width * .045,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              isArabic ? Icons.arrow_forward : Icons.arrow_back,
              color: AppColors.darkGreen,
            ),
            onPressed: Get.back,
          ),
          actions: [
            Obx(() {
              if (controller.unreadCount.value == 0) {
                return const SizedBox();
              }
              return IconButton(
                onPressed: controller.markAllAsRead,
                tooltip: "mark_all_read".tr,
                icon: Icon(
                  Icons.library_add_check_outlined,
                  color: AppColors.primaryColor,
                  size: 23,
                ),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            NotificationTabs(controller: controller),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  if (controller.selectedTab.value == 0) {
                    await controller.loadNotifications();
                  } else {
                    await controller.loadUnreadNotifications();
                  }
                  await controller.loadUnreadCount();
                },
                child: Obx(() {
                  final currentNotifications = controller.selectedTab.value == 0
                      ? controller.notifications
                      : controller.unreadNotifications;
                  if (controller.loading.value && currentNotifications.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (currentNotifications.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: size.height * .25),
                        Icon(
                          Icons.notifications_none_rounded,
                          size: size.width * .2,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: Text(
                            controller.selectedTab.value == 0
                                ? "no_notifications".tr
                                : "no_unread_notifications".tr,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: size.width * .04,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification &&
                          notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent - 200) {
                        if (controller.selectedTab.value == 0) {
                          controller.loadNotifications(refresh: false);
                        } else {
                          controller.loadUnreadNotifications(refresh: false);
                        }
                      }
                      return false;
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(size.width * .04),
                      itemCount:
                          currentNotifications.length +
                          (controller.loadingMore.value ? 1 : 0),
                      separatorBuilder: (_, __) =>
                          SizedBox(height: size.height * .012),
                      itemBuilder: (context, index) {
                        if (index >= currentNotifications.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final notification = currentNotifications[index];
                        return NotificationCard(
                          notification: notification,
                          size: size,
                          onTap: () {
                            controller.markAsRead(notification);
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
