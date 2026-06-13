import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';

class SendMessageHeaderBanner extends StatelessWidget {
  final double w;
  final double h;
  const SendMessageHeaderBanner({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.055, vertical: h * 0.025),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              'نحن هنا للمساعدة. أرسل لنا رسالتك وسنرد عليك في أقرب وقت ممكن.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: w * 0.036,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(width: w * 0.03),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}
