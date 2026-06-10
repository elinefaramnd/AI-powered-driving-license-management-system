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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: const Color(0xFFF6F7F7),
        drawer: const HomeDrawerWidget(),
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  HomeHeaderWidget(controller: controller),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primary,

                      onRefresh: () async {
                        await controller.getCurrentApplication();
                      },

                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),

                        padding: const EdgeInsets.all(14),

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
            ),

            ChatBotWidget(),
          ],
        ),
      ),
    );
  }
}
