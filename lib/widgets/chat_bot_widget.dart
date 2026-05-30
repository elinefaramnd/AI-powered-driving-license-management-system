import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import 'chat_bot_controller.dart';

class ChatBotWidget extends StatelessWidget {
  ChatBotWidget({super.key});
  final ChatBotController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: size.height * 0.025,
      left: size.width * 0.05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                        offset: Offset(-size.width * 0.12, 0),
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
                                      "مرحبا! أنا المساعد الذكي الخاص بتطبيق سيرتك..\nكيف يمكنني مساعدتك؟",
                                      style: TextStyle(
                                        fontSize: size.width * 0.031,
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

          SizedBox(width: size.width * 0.02),
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
              onPressed: () {},
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: size.width * 0.065,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
