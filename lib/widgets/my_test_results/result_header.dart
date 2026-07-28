import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../app_theme/app_colors.dart';

class ResultHeader extends StatelessWidget {
  final Size size;
  final String result;

  const ResultHeader({
    super.key,
    required this.size,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isPassed = result == "passed";

    final smallSpace = size.height * 0.012;
    final bigSpace = size.height * 0.03;

    final titleFont = size.width * 0.04;
    final subtitleFont = size.width * 0.032;

    return Column(
      children: [
        Container(
          width: size.width * 0.13,
          height: size.width * 0.13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPassed
                ? AppColors.primaryColor
                : Colors.red,
          ),
          child: Icon(
            isPassed ? Icons.check : Icons.close,
            color: Colors.white,
            size: size.width * 0.07,
          ),
        ),

        SizedBox(height: smallSpace),

        Text(
          isPassed
              ? "test_passed_successfully".tr
              : "test_failed".tr,
          style: TextStyle(
            fontSize: titleFont,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: smallSpace / 2),

        Text(
          isPassed
              ? "result_recorded_successfully".tr
              : "failure_recorded".tr,
          style: TextStyle(
            fontSize: subtitleFont,
            color: Colors.grey,
          ),
        ),

        SizedBox(height: bigSpace),
      ],
    );
  }
}