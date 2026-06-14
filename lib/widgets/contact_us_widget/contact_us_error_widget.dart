import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'contact_us_app_bar.dart';

class ContactUsErrorWidget extends StatelessWidget {
  final double w;
  final double h;
  final String message;
  final VoidCallback onRetry;

  const ContactUsErrorWidget({
    super.key,
    required this.w,
    required this.h,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactUsAppBar(w: w),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.wifi_off_rounded,
                        color: Color(0xFFE65100), size: 48),
                  ),
                  SizedBox(height: h * 0.025),
                  Text(
                    message,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                    label: const Text(
                      'إعادة المحاولة',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.08, vertical: h * 0.016),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
