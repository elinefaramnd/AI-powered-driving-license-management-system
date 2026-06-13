import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';
import '../../modules/logout/logout_controller.dart';
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
                      title: "الرئيسية",
                      index: 0,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.person_outline,
                      title: "الملف الشخصي",
                      index: 12,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('showPro');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.list_alt,
                      title: "طلباتي",
                      index: 1,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/order_screen");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.calendar_today_outlined,
                      title: "مواعيدي",
                      index: 3,
                      controller: controller,
                    ),

                     DrawerItemWidget(
                      icon: Icons.fact_check_outlined,
                      title: "اختباراتي ونتائجي",
                      index: 4,
                      controller: controller,
                       onTap: (){
                         Get.toNamed(
                           'available_tests_page',
                           arguments: controller.applicationId.value,);
                       },
                    ),
                    DrawerItemWidget(
                      icon: Icons.badge_outlined,
                      title: "رخصي",
                      index: 5,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/my_licenses");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.gavel_outlined,
                      title: "غراماتي",
                      index: 6,
                      controller: controller,
                      onTap: () {
                        Get.toNamed("/fines_screen");
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.credit_card_rounded,
                      title: "الدفع الإلكتروني",
                      index: 7,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.lock_open,
                      title: "فك حجز رخصة",
                      index: 10,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.notifications_none,
                      title: "الإشعارات",
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
                            "الخدمات",
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
                              title: "طلب إصدار جديد",
                              index: 2,
                              controller: controller,
                              onTap: controller.openNewApplication,
                            ),
                            DrawerItemWidget(
                              icon: Icons.refresh,
                              title: "تجديد رخصة",
                              index: 8,
                              controller: controller,
                              onTap: () {},
                            ),
                            DrawerItemWidget(
                              icon: Icons.description_outlined,
                              title: "بدل فاقد / تالف",
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
                      title: "المساعدة والدعم",
                      index: 14,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.settings_outlined,
                      title: "الإعدادات",
                      index: 13,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/settings');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.support_agent,
                      title: "الأسئلة الشائعة (FAQ)",
                      index: 14,
                      controller: controller,
                    ),
                    DrawerItemWidget(
                      icon: Icons.shield_outlined,
                      title: "سياسة الخصوصية",
                      index: 15,
                      controller: controller,
                      onTap: () {
                        Get.toNamed('/privacy_policy');
                      },
                    ),
                    DrawerItemWidget(
                      icon: Icons.headset_mic_rounded,
                      title: "تواصل معنا",
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
                        "تسجيل خروج",
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
