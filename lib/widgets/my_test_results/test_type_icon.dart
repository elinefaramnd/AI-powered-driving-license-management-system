import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/test_results/test_result_model.dart';
import '../../modules/test_results/test_results_controller.dart';
class TestTypeIcon extends StatelessWidget {
  final TestResultModel testResult;
  final bool isPassed;
  final bool isFailed;

  TestTypeIcon({
    super.key,
    required this.testResult,
    required this.isPassed,
    required this.isFailed,
  });

  final controller = Get.find<TestResultsController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(
        size.width * .035,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          size.width * .04,
        ),
      ),
      child: Icon(
        controller.getTestTypeIcon(
          testResult.testType.code,
        ),
        size: size.width * .07,
        color: isPassed
            ? AppColors.primaryColor
            : isFailed
            ? Colors.red[600]
            : AppColors.gold,
      ),
    );
  }
}