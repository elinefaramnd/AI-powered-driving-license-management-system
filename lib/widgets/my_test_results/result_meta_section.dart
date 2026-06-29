import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/my_test_results/test_results_controller.dart';

class ResultMetaSection extends StatelessWidget {
  final Size size;
  final dynamic item;
  final TestResultsController controller;

  const ResultMetaSection({
    super.key,
    required this.size,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final smallSpace = size.height * 0.012;
    final smallFont = size.width * 0.033;
    final subtitleFont = size.width * 0.032;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: size.width * 0.06,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: size.width * 0.02),
                Text(
                  "التاريخ",
                  style: TextStyle(
                    fontSize: smallFont,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: smallSpace / 2),
            Text(
              controller.getDate(item.recordedAt),
              style: TextStyle(
                fontSize: subtitleFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Column(
          children: [
            Text(
              "عدد المحاولات",
              style: TextStyle(
                fontSize: smallFont,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: smallSpace / 2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.012,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF2F4F7),
                borderRadius:
                BorderRadius.circular(size.width * 0.07),
              ),
              child: Text(
              item.attemptNumber.toString(),
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}