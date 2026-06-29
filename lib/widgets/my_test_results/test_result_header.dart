import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/my_test_results/result_badge.dart';
import 'package:project_2/widgets/my_test_results/test_type_icon.dart';
import 'package:project_2/widgets/my_test_results/test_type_info.dart';
import '../../modules/test_results/test_result_model.dart';
import '../../modules/test_results/test_results_controller.dart';
class TestResultHeader extends StatelessWidget {
  final TestResultModel testResult;
  final bool isPassed;
  final bool isFailed;

  TestResultHeader({
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
        size.width * .05,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPassed
              ? [Colors.green[50]!, Colors.green[100]!]
              : isFailed
              ? [Colors.red[50]!, Colors.red[100]!]
              : [Colors.orange[50]!, Colors.orange[100]!],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            size.width * .05,
          ),
          topRight: Radius.circular(
            size.width * .05,
          ),
        ),
      ),
      child: Row(
        children: [
          TestTypeIcon(
            testResult: testResult,
            isPassed: isPassed,
            isFailed: isFailed,
          ),

          SizedBox(
            width: size.width * .04,
          ),

          Expanded(
            child: TestTypeInfo(
              testResult: testResult,
            ),
          ),

          ResultBadge(
            result: testResult.result,
            isPassed: isPassed,
            isFailed: isFailed,
          ),
        ],
      ),
    );
  }}