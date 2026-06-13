import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/modules/contact_us/contact_us_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact_us_clipboard_helper.dart';

class ContactUsChannelCard extends StatelessWidget {
  final double w;
  final double h;
  final ContactChannel channel;
  const ContactUsChannelCard({super.key, required this.w, required this.h, required this.channel});

  Future<void> _handleTap() async {
    final isPhone = channel.type == 'phone';
    copyToClipboard(channel.value);
    if (isPhone) {
      final uri = Uri(scheme: 'tel', path: channel.value);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = channel.type == 'phone';
    final iconData = isPhone ? Icons.phone_in_talk_rounded : Icons.alternate_email_rounded;
    final gradientColors = [AppColors.mediumGreen, AppColors.darkGreen];

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.045, vertical: h * 0.018),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightGreenBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.copy_rounded,
                  color: AppColors.mediumGreen, size: 18),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  channel.label,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  channel.value,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1C1C1E),
                  ),
                ),
              ],
            ),
            SizedBox(width: w * 0.03),
            Container(
              width: w * 0.1,
              height: w * 0.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.last.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(iconData, color: Colors.white, size: w * 0.045),
            ),
          ],
        ),
      ),
    );
  }
}
