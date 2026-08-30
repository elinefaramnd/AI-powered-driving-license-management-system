import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class SendButton extends StatelessWidget {
  final Size size;
  final Future<void> Function() onTap;
  const SendButton({
    super.key,
    required this.size,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTap();
      },
      child: Container(
        width: size.width * 0.105,
        height: size.width * 0.105,
        decoration: BoxDecoration(
          color: AppColors.gold,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.28),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: size.width * 0.048,
        ),
      ),
    );
  }
}