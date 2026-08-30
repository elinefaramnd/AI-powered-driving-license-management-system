import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class ResultHeader extends StatelessWidget {
  final Size size;
  final bool isArabic;
  final bool isPassed;
  final bool isFailed;
  final Color resultColor;
  final String resultText;

  const ResultHeader({
    super.key,
    required this.size,
    required this.isArabic,
    required this.isPassed,
    required this.isFailed,
    required this.resultColor,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: isArabic
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.035,
                      vertical: size.height * 0.007,
                    ),
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white.withOpacity(0.35)),
                    ),
                    child: Text(
                      resultText,
                      textDirection: isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.009),

                Align(
                  alignment: isArabic
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    isPassed ? "test_passed_successfully".tr : "test_failed".tr,
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.005),

                Align(
                  alignment: isArabic
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    isPassed
                        ? "result_recorded_successfully".tr
                        : "failure_recorded".tr,
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontSize: size.width * 0.031,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: size.width * 0.035),

          Container(
            width: size.width * 0.17,
            height: size.width * 0.17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffF4D477),
                  Color(0xffB88A22),
                  Color(0xffF2D36B),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 7,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(size.width * 0.009),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: resultColor,
                border: Border.all(color: const Color(0xffF7E5A1), width: 2),
              ),
              child: Icon(
                isPassed
                    ? Icons.check
                    : isFailed
                    ? Icons.close
                    : Icons.hourglass_empty,
                color: Colors.white,
                size: size.width * 0.075,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
