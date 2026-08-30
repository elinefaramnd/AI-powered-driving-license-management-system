import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/my_test_results/test_result_model.dart';
import '../../modules/my_test_results/test_results_controller.dart';
import 'result_header.dart';
import 'test_type_section.dart';
import 'details_section.dart';

class ResultCard extends StatelessWidget {
  final Size size;
  final TestResultModel item;
  final TestResultsController controller;
  const ResultCard({
    super.key,
    required this.size,
    required this.item,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    final isPassed = item.result == "passed";
    final isFailed = item.result == "failed";
    final resultColor = isPassed
        ? AppColors.primaryColor
        : isFailed
        ? const Color(0xff8B2635)
        : AppColors.gold;
    final resultText = controller.getResultText(item.result);
    final notes = controller.getNotes(item.notes);
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.018),
      decoration: BoxDecoration(
        color: const Color(0xffFDFDFC),
        borderRadius: BorderRadius.circular(size.width * 0.04),
        border: Border.all(color: const Color(0xffE8E4DC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ResultHeader(
            size: size,
            isArabic: isArabic,
            isPassed: isPassed,
            isFailed: isFailed,
            resultColor: resultColor,
            resultText: resultText,
          ),
          SizedBox(height: size.height * 0.008),
          TestTypeSection(
            size: size,
            item: item,
            controller: controller,
            isArabic: isArabic,
          ),
          SizedBox(height: size.height * 0.008),
          DetailsSection(
            size: size,
            isArabic: isArabic,
            resultText: resultText,
            resultColor: resultColor,
            notes: notes,
            attemptNumber: item.attemptNumber.toString(),
            date: controller.getDate(item.recordedAt),
            recordedBy: item.recordedBy,
          ),
          SizedBox(height: size.height * 0.025),
        ],
      ),
    );
  }
}
