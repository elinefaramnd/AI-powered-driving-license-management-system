import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../modules/test_results/test_results_controller.dart';
import 'stat_card.dart';

class SummarySection extends StatelessWidget {
  final TestResultsController controller;

  const SummarySection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final passedCount = controller.passedCount;
      final totalCount = controller.testResults.length;
      final allPassed = passedCount == totalCount && totalCount > 0;

      return Column(
        children: [
          // Success Banner (if all tests passed)
          if (allPassed)
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green[400]!,
                    Colors.green[600]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.emoji_events_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تهانينا!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'لقد اجتزت جميع الاختبارات بنجاح',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    bgColor: Colors.green[50]!,
                    value: passedCount.toString(),
                    label: 'ناجح',
                    progress: totalCount > 0 ? passedCount / totalCount : 0,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.fact_check_outlined,
                    iconColor: AppColors.primary,
                    bgColor: AppColors.background,
                    value: totalCount.toString(),
                    label: 'إجمالي الاختبارات',
                    showProgress: false,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'تفاصيل النتائج',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 3,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      );
    });
  }
}