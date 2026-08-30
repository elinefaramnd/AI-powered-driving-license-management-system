import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/chat_bot_widget/chat_bot.dart';
import '../../widgets/home_widget/home_drawer_widget.dart';
import '../../widgets/home_widget/home_header_widget.dart';
import '../../widgets/home_widget/order_card_widget.dart';
import '../../widgets/home_widget/services_grid_widget.dart';
import '../../widgets/home_widget/timeline_card_widget.dart';
import 'home_controller.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: const Color(0xFFF6F7F7),
        drawer: const HomeDrawerWidget(),
        drawerEnableOpenDragGesture: controller.canUseServices,
        body: Stack(
          children: [
            SafeArea(
              child: Obx(() {
                if (controller.loadingHome.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ClipPath(
                        clipper: _HeaderBottomClipper(),
                        child: Container(
                          height: 185,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        HomeHeaderWidget(controller: controller),
                        Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () async {
                              await controller.loadHome();
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                10,
                                14,
                                14,
                              ),
                              child: Column(
                                children: [
                                  OrderCardWidget(),
                                  const SizedBox(height: 12),
                                  TimelineCardWidget(),
                                  const SizedBox(height: 12),
                                  ServicesGridWidget(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            ChatBotWidget(),
          ],
        ),
      ),
    );
  }
}
class _HeaderBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.68);
    path.quadraticBezierTo(
      size.width * 0.88,
      size.height * 0.82,
      size.width * 0.72,
      size.height * 0.78,
    );
    path.quadraticBezierTo(
      size.width * 0.50,
      size.height * 0.72,
      size.width * 0.28,
      size.height * 0.78,
    );
    path.quadraticBezierTo(
      size.width * 0.12,
      size.height * 0.82,
      0,
      size.height * 0.68,
    );
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
