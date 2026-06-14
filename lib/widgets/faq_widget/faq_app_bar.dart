import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class FaqAppBar extends StatelessWidget {
  final double w;
  const FaqAppBar({super.key, required this.w});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.045, vertical: w * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.darkGreen),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Syrtak',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.question_answer, color: AppColors.darkGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FaqHeroBanner extends StatelessWidget {
  final double w;
  final double h;

  const FaqHeroBanner({super.key, required this.w, required this.h});

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
                          'إجابات سريعة لأكثر الأسئلة\nحول خدمات رخص القيادة',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.042,
                            fontWeight: FontWeight.w600,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: h * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'ابحث عن إجابتك بسهولة',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: w * 0.033,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.lightbulb_outline, color: AppColors.gold, size: 15),
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
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.help_outline_rounded, color: AppColors.gold, size: w * 0.09),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
            child: const Icon(Icons.question_mark, color: Colors.white, size: 12),
          ),
        ),
      ],
    );
  }
}
