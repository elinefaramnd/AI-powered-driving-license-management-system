import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';
import '../helpers/cloud_clipper.dart';

class ChatBotWidget extends StatelessWidget {
  const ChatBotWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;
    return Positioned(
      bottom: size.height * 0.025,
      left: size.width * 0.05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Transform.translate(
            offset: Offset(
              -size.width * 0.11,
              -size.height * 0.065,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  painter: CloudBorderPainter(),
                  child: ClipPath(
                    clipper: CloudClipper(),
                    child: Container(
                      width: size.width * 0.48,
                      height: size.height * 0.12,

                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.045,
                        vertical: size.height * 0.022,
                      ),
                      color: const Color(0xffFCFFF1).withOpacity(0.95),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: Text(
                              "مرحبا! أنا المساعد الذكي الخاص بتطبيق سيرتك..\nكيف يمكنني مساعدتك؟",
                              style: TextStyle(
                                fontSize: 12 * scale,
                                color: AppColors.gold,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  blurRadius: 12,
                  offset: const Offset(0, 5),
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