import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/chat_bot_widget.dart';
import '../../widgets/home_drawer_widget.dart';
import '../../widgets/home_header_widget.dart';
import '../../widgets/order_card_widget.dart';
import '../../widgets/services_grid_widget.dart';
import '../../widgets/timeline_card_widget.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: const Color(0xFFF6F7F7),
        drawer: HomeDrawerWidget(controller: controller),
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    HomeHeaderWidget(controller: controller),
                    Expanded(
                      child: SingleChildScrollView(
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
                  ],
                ),
              ),

              const ChatBotWidget(),
            ],
          ),
        ),
    );
  }
}


