import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';
import '../../modules/logout/logout_controller.dart';
import '../../modules/my_test_results/TestResultsView.dart';
import 'drawer_item_widget.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final logoutController = Get.put(LogOutController());
    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;
    return Drawer(
      width: size.width * 0.65,
      child: Container(
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: scale * 12),
              Text(
                "SYRTAK",
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.15),
                indent: size.width * 0.05,
                endIndent: size.width * 0.05,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerItemWidget(
                      icon: Icons.home,
                      title:"home".tr,
                      index: 0,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.person_outline,
                      title: "profile".tr,
                      index: 12,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('showPro');

                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.list_alt,
                      title: "my_requests".tr,
                      index: 1,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/order_screen");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.calendar_today_outlined,
                      title: "appointments".tr,
                      index: 3,
                      controller: controller,
                      onTap: (){
                        Get.toNamed(
                          '/appointments',
                          arguments: controller.applicationId.value,
                        );
                      },
                    ),

                     DrawerItemWidget(
                      icon: Icons.fact_check_outlined,
                      title: "my_tests_results".tr,
                      index: 4,
                      controller: controller,
                       onTap: (){
                         Get.toNamed(
                           'available_tests_page',
                           arguments: controller.applicationId.value,);
                       },
                    ),
                    DrawerItemWidget(
                      icon: Icons.person_outline,
                      title: "results".tr,
                      index: 18,
                      controller: controller,
                      onTap: () {
                        Get.to(()=>TestResultsView(), arguments: controller.applicationId.value,);

                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.badge_outlined,
                      title: "my_licenses".tr,
                      index: 5,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/my_licenses");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.gavel_outlined,
                      title: "fines".tr,
                      index: 6,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/fines_screen");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.credit_card_rounded,
                      title: "electronic_payment".tr,
                      index: 7,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.lock_open,
                      title: "unlock_license".tr,
                      index: 10,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.notifications_none,
                      title: "notifications".tr,
                      index: 11,
                      controller: controller,
                    ),

                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: Obx(() {
                        return ExpansionTile(
                          onExpansionChanged: (value) {
                            controller.isServicesExpanded.value = value;
                          },
                          tilePadding: EdgeInsets.symmetric(
                            horizontal: size.width * .04,
                          ),
                          childrenPadding: EdgeInsets.zero,
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          leading: Icon(
                            Icons.dashboard_customize_outlined,
                            color: Colors.white,
                            size: 22 * scale,
                          ),
                          title: Text(
                            "services".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14 * scale,
                            ),
                          ),
                          trailing: Icon(
                            controller.isServicesExpanded.value
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_left,
                            color: Colors.white,
                          ),
                          children: [
                            DrawerItemWidget(
                              icon: Icons.add_circle_outline,
                              title: "new_license_request".tr,
                              index: 2,
                              controller: controller,
                              onTap: controller.openNewApplication,
                            ),
                            DrawerItemWidget(
                              icon: Icons.refresh,
                              title: "renew_license".tr,
                              index: 8,
                              controller: controller,
                              onTap: () {},
                            ),
                            DrawerItemWidget(
                              icon: Icons.description_outlined,
                              title: "replacement_license".tr,
                              index: 9,
                              controller: controller,
                              onTap: () {},
                            ),
                          ],
                        );
                      }),
                    ),
                    DrawerItemWidget(
                      icon: Icons.support_agent,
                      title: "support".tr,
                      index: 14,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.settings_outlined,
                      title: "settings".tr,
                      index: 13,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/settings');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.help_outline_rounded,
                      title: "faq".tr,
                      index: 17,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/faq');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.shield_outlined,
                      title: "privacy_policy".tr,
                      index: 15,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/privacy_policy');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.headset_mic_rounded,
                      title: "contact_us".tr,
                      index: 16,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/contact_us');
                      },
                    ),
                    SizedBox(height: size.height * 0.015),
                    Divider(
                      color: Colors.white.withOpacity(0.15),
                      indent: size.width * 0.05,
                      endIndent: size.width * 0.05,
                    ),
                    ListTile(
                      onTap: () {
                        logoutController.logout();
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 22 * scale,
                      ),
                      title: Text(
                        "logout".tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14 * scale,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
