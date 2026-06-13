import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';

class PrivacyPolicyHeroBanner extends StatelessWidget {
  final double w;
  final double h;
  final String lastUpdated;

  const PrivacyPolicyHeroBanner({
    super.key,
    required this.w,
    required this.h,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF062E2B), Color(0xFF0B5E58)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(w * 0.045),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeroIllustration(w: w),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'نحمي بياناتك ونستخدمها فقط\nلتقديم الخدمات المرورية\nبأمان وشفافية',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.042,
                            fontWeight: FontWeight.w600,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: h * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _formatDate(lastUpdated),
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.calendar_today_outlined, color:AppColors.gold, size: 15),
                          ],
                        ),
                      ],
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

  String _formatDate(String raw) {
    if (raw.isEmpty) return '';
    try {
      final parts = raw.split('-');
      if (parts.length != 3) return raw;
      const months = [
        '', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
        'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
      ];
      final month = int.tryParse(parts[1]) ?? 0;
      return 'آخر تحديث: ${parts[2]} ${months[month]} ${parts[0]}';
    } catch (_) {
      return raw;
    }
  }
}

class _HeroIllustration extends StatelessWidget {
  final double w;
  const _HeroIllustration({required this.w});


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: w * 0.22,
          height: w * 0.22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        Container(
          width: w * 0.16,
          height: w * 0.16,
          decoration: BoxDecoration(
            color: const Color(0xFF0D5C56),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.shield_outlined, color: AppColors.gold, size: w * 0.09),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 12),
          ),
        ),
      ],
    );
  }
}
