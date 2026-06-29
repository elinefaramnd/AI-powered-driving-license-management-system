import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/test_results/test_results_controller.dart';

class ResultBadge extends StatelessWidget {
  final String result;
  final bool isPassed;
  final bool isFailed;

  const ResultBadge({
    super.key,
    required this.result,
    required this.isPassed,
    required this.isFailed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestResultsController>();

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPassed
                ? Icons.check_circle
                : isFailed
                ? Icons.cancel
                : Icons.hourglass_empty,
          ),
          Text(
            controller.getResultText(result),
          ),
        ],
      ),
    );
  }
}