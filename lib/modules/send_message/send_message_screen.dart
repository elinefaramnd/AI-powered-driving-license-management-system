import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/widgets/send_message_widget/send_message_app_bar.dart';
import 'package:project_2/widgets/send_message_widget/send_message_form_card.dart';
import 'package:project_2/widgets/send_message_widget/send_message_header_banner.dart';
import 'send_message_controller.dart';

class SendMessageScreen extends StatelessWidget {
  const SendMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SendMessageController>()
        ? Get.find<SendMessageController>()
        : Get.put(SendMessageController());
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SendMessageAppBar(w: w),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: h * 0.02),
                      SendMessageHeaderBanner(w: w, h: h),
                      SizedBox(height: h * 0.025),
                      SendMessageFormCard(w: w, h: h, controller: controller),
                      SizedBox(height: h * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
