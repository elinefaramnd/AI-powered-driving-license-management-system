import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/my_test_results/test_result_model.dart';
import '../../modules/my_test_results/test_results_controller.dart';

class TestTypeSection extends StatelessWidget {
  final Size size;
  final TestResultModel item;
  final TestResultsController controller;
  final bool isArabic;

  const TestTypeSection({
    super.key,
    required this.size,
    required this.item,
    required this.controller,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.035,
        vertical: size.height * 0.016,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.025),
        border: Border.all(color: const Color(0xffE8E4DC)),
      ),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            width: size.width * 0.075,
            height: size.width * 0.075,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              item.testCode == "vision"
                  ? Icons.visibility_outlined
                  : item.testCode == "theory"
                  ? Icons.menu_book_outlined
                  : item.testCode == "practical"
                  ? Icons.directions_car_outlined
                  : Icons.assignment_outlined,
              color: AppColors.gold,
              size: size.width * 0.04,
            ),
          ),

          SizedBox(width: size.width * 0.025),

          Expanded(
            child: Column(
              crossAxisAlignment: isArabic
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  item.testName,
                  textAlign: isArabic ? TextAlign.start : TextAlign.end,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade800,
                  ),
                ),

                SizedBox(height: size.height * 0.004),

                Text(
                  controller.getTestDescription(item.testCode),
                  textAlign: isArabic ? TextAlign.start : TextAlign.end,
                  style: TextStyle(
                    fontSize: size.width * 0.027,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
