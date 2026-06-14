import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class FaqErrorWidget extends StatelessWidget {
  final double w;
  final double h;
  final String message;
  final VoidCallback onRetry;

  const FaqErrorWidget({
    super.key,
    required this.w,
    required this.h,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.lightGreenBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.primary,
                size: w * 0.12,
              ),
            ),
            SizedBox(height: h * 0.025),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.04,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: h * 0.03),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              label: Text(
                'إعادة المحاولة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.038,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.08,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
