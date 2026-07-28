import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
class FaqHeroBanner extends StatelessWidget {
  final double w;
  final double h;

  const FaqHeroBanner({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color(0xFF062E2B), Color(0xFF0B5E58)],
            begin:
            isArabic ? Alignment.centerLeft : Alignment.centerRight,
            end:
            isArabic ? Alignment.centerRight : Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              left: isArabic ? null : -20,
              right: isArabic ? -20 : null,
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
              left: isArabic ? null : 10,
              right: isArabic ? 10 : null,
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
                textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeroIllustration(w: w),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "faq_banner_title".tr,
                          textAlign:
                          isArabic ? TextAlign.right : TextAlign.left,
                          textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isArabic?w * 0.042:w *0.035,
                            fontWeight: FontWeight.w600,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: h * 0.012),
                        Row(
                          textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                          mainAxisAlignment: isArabic
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline, color: AppColors.gold, size: 15),
                            const SizedBox(width: 5),
                            Text(
                              "faq_banner_subtitle".tr,
                              textAlign:isArabic ? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: w * 0.033,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
    final isArabic = Get.locale?.languageCode == "ar";
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
