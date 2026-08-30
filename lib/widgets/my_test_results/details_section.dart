import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import 'detail_item.dart';

class DetailsSection extends StatelessWidget {
  final Size size;
  final bool isArabic;
  final String resultText;
  final Color resultColor;
  final String notes;
  final String attemptNumber;
  final String date;
  final String recordedBy;

  const DetailsSection({
    super.key,
    required this.size,
    required this.isArabic,
    required this.resultText,
    required this.resultColor,
    required this.notes,
    required this.attemptNumber,
    required this.date,
    required this.recordedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.025,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          size.width * 0.025,
        ),
        border: Border.all(
          color: const Color(0xffE8E4DC),
        ),
      ),
      child: Column(
        children: [
          DetailItem(
            size: size,
            icon: Icons.info_outline,
            title: "status",
            value: resultText,
            valueColor: resultColor,
            isArabic: isArabic,
          ),
          const DetailDivider(),
          DetailItem(
            size: size,
            icon: Icons.repeat,
            title: "attempts_count",
            value: attemptNumber,
            valueColor: AppColors.primaryColor,
            isArabic: isArabic,
          ),
          const DetailDivider(),
          DetailItem(
            size: size,
            icon: Icons.calendar_month_outlined,
            title: "date",
            value: date,
            valueColor: Colors.grey.shade800,
            isArabic: isArabic,
          ),
          const DetailDivider(),
          DetailItem(
            size: size,
            icon: Icons.description_outlined,
            title: "notes",
            value: notes,
            valueColor: Colors.grey.shade800,
            isArabic: isArabic,
          ),
          const DetailDivider(),
          DetailItem(
            size: size,
            icon: Icons.person_outline,
            title: "recorded_by",
            value: recordedBy,
            valueColor: Colors.grey.shade800,
            isArabic: isArabic,
          ),
        ],
      ),
    );
  }
}