import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app_theme/app_colors.dart';
import 'test_result_model.dart';
import 'test_results_controller.dart';
import 'package:get/get.dart';

class TestResultCard extends StatelessWidget {
  final TestResultModel testResult;
  final controller = Get.find<TestResultsController>();

  TestResultCard({super.key, required this.testResult});

  @override
  Widget build(BuildContext context) {
    final isPassed = testResult.result == 'passed';
    final isFailed = testResult.result == 'failed';
    final isPending = testResult.result == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with gradient
          Container(
            padding: const EdgeInsets.all(20),
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Test Type Icon
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    controller.getTestTypeIcon(testResult.testType.code),
                    color: isPassed
                        ? Colors.green[600]
                        : isFailed
                            ? Colors.red[600]
                            : Colors.orange[600],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.getTestTypeName(testResult.testType.code),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        testResult.testType.name,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Result Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isPassed
                        ? Colors.green[600]
                        : isFailed
                            ? Colors.red[600]
                            : Colors.orange[600],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (isPassed
                                ? Colors.green[600]!
                                : isFailed
                                    ? Colors.red[600]!
                                    : Colors.orange[600]!)
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPassed
                            ? Icons.check_circle
                            : isFailed
                                ? Icons.cancel
                                : Icons.hourglass_empty,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.getResultText(testResult.result),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Details Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildDetailRow(
                  icon: Icons.repeat,
                  label: 'رقم المحاولة',
                  value: '${testResult.attemptNumber}',
                  valueColor: AppColors.primaryColor,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'تاريخ التسجيل',
                  value: DateFormat('yyyy/MM/dd - HH:mm')
                      .format(testResult.recordedAt.toLocal()),
                  valueColor: Colors.grey[700]!,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.person_outline,
                  label: 'مسجل النتيجة',
                  value: testResult.recordedBy.name,
                  valueColor: Colors.grey[700]!,
                ),
                if (testResult.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notes_outlined,
                              size: 16,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'ملاحظات',
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          testResult.notes,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
