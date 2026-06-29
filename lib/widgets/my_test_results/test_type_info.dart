import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/test_results/test_result_model.dart';
import '../../modules/test_results/test_results_controller.dart';
class TestTypeInfo extends StatelessWidget {
  final TestResultModel testResult;

  const TestTypeInfo({
    super.key,
    required this.testResult,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestResultsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.getTestTypeName(
            testResult.testType.code,
          ),
        ),
        Text(
          testResult.testType.name,
        ),
      ],
    );
  }
}