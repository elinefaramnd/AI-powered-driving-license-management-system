import 'package:get/get.dart';
import 'package:project_2/modules/test_results/test_result_model.dart';
import 'package:project_2/modules/test_results/test_results_controller.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/my_test_results/test_result_details.dart';
import '../../widgets/my_test_results/test_result_header.dart';
import 'package:flutter/material.dart';

class TestResultCard extends StatelessWidget {
  final TestResultModel testResult;

  final controller = Get.find<TestResultsController>();

  TestResultCard({super.key, required this.testResult});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isPassed = testResult.result == 'passed';
    final isFailed = testResult.result == 'failed';

    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          size.width * .05,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(.08),
            blurRadius: size.width * .05,
            offset: Offset(
              0,
              size.height * .01,
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          TestResultHeader(
            testResult: testResult,
            isPassed: isPassed,
            isFailed: isFailed,
          ),

          TestResultDetails(
            testResult: testResult,
          ),
        ],
      ),
    );
  }}