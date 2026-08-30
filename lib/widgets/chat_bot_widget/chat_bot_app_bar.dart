import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ChatBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final VoidCallback onBack;
  const ChatBotAppBar({super.key, required this.size, required this.onBack});
  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.095);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: size.height * 0.095,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, size: 28),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " SYRTAK AI Assistant",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: size.width * 0.048,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: size.width * 0.012),
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.gold,
                      size: size.width * 0.035,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width * 0.105,
              height: size.width * 0.105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.20),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.smart_toy_rounded,
                    color: Colors.white,
                    size: size.width * 0.055,
                  ),
                  Positioned(
                    right: size.width * 0.008,
                    top: size.width * 0.008,
                    child: Icon(
                      Icons.auto_awesome,
                      color: AppColors.gold,
                      size: size.width * 0.025,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
