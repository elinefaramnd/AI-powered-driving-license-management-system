import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ChatBotAvatar extends StatelessWidget {
  final Size size;
  const ChatBotAvatar({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size.width * 0.105,
          height: size.width * 0.105,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.gold, const Color(0xFF9A783B)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.smart_toy_rounded,
            color: Colors.white,
            size: size.width * 0.052,
          ),
        ),
        Positioned(
          top: -4,
          right: -3,
          child: Icon(
            Icons.auto_awesome,
            color: AppColors.gold,
            size: size.width * 0.035,
          ),
        ),
        Positioned(
          bottom: -2,
          left: -4,
          child: Icon(
            Icons.star_rounded,
            color: AppColors.gold,
            size: size.width * 0.025,
          ),
        ),
      ],
    );
  }
}

class ChatUserAvatar extends StatelessWidget {
  final Size size;
  const ChatUserAvatar({super.key, required this.size});
  static const Color darkGreen = Color(0xFF004D40);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.105,
      height: size.width * 0.105,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: darkGreen,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: darkGreen.withOpacity(0.20),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.person_rounded,
        color: Colors.white,
        size: size.width * 0.052,
      ),
    );
  }
}
