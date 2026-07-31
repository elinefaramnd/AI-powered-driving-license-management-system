import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import '../../modules/home_page/home_controller.dart';
import '../app_snackbar.dart';

class ChatBotWidget extends StatelessWidget {
  ChatBotWidget({super.key});
  final ChatController controller = Get.find();
  final HomeController home = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: size.height * 0.025,
      left: size.width * 0.07,
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: size.width * 0.145,
            height: size.width * 0.145,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: size.width * 0.03,
                  offset: Offset(0, size.height * 0.005),
                ),
              ],
            ),

            child: IconButton(
              onPressed: () {
                final status = home.profileStatus.value;

                if (status != "approved") {
                  AppSnackbar.show(
                    "warning".tr,
                    status == "pending_review"
                        ? "account_under_review".tr
                        : status == "rejected"
                        ? "profile_rejected".tr
                        : "complete_profile_first".tr,
                  );
                  return;
                }

                controller.openChatScreen();
              },
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: size.width * 0.065,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.002),
          Obx(
            () => controller.showMessage.value
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.001,
                        bottom: size.height * 0.015 + size.height * 0.071,
                      ),
                      child: Transform.translate(
                        offset: Offset(-size.width * 0.035, 0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: size.width * 0.45,
                              height: size.height * 0.12,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.045,
                                vertical: size.height * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xffFCFFF1,
                                ).withOpacity(0.92),
                                borderRadius: BorderRadius.circular(
                                  size.width * 0.04,
                                ),
                                border: Border.all(
                                  color: AppColors.gold,
                                  width: size.width * 0.003,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: size.width * 0.03,
                                    offset: Offset(0, size.height * 0.005),
                                  ),
                                ],
                              ),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("CLOSE CLICKED");
                                      controller.close();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: size.width * 0.045,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      "chatbot_welcome".tr,
                                      style: TextStyle(
                                        fontSize: size.width * 0.03,
                                        color: AppColors.gold,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -size.height * 0.012,
                              left: size.width * 0.10,
                              child: Transform.rotate(
                                angle: 0.78,
                                child: Container(
                                  width: size.width * 0.045,
                                  height: size.width * 0.045,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xffFCFFF1,
                                    ).withOpacity(0.97),
                                    border: Border(
                                      right: BorderSide(
                                        color: AppColors.gold,
                                        width: size.width * 0.003,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.gold,
                                        width: size.width * 0.003,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
