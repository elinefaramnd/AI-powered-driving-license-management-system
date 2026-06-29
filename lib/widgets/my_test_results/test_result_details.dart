import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2/widgets/my_test_results/test_result_notes.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/test_results/test_result_model.dart';
import 'detail_row.dart';
class TestResultDetails extends StatelessWidget {
  final TestResultModel testResult;

  const TestResultDetails({
    super.key,
    required this.testResult,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(
        size.width * .05,
      ),
      child: Column(
        children: [
          DetailRow(
            icon: Icons.repeat,
            label: 'رقم المحاولة',
            value: '${testResult.attemptNumber}',
            valueColor: AppColors.primaryColor,
          ),

          SizedBox(
            height: size.height * .015,
          ),

          DetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'تاريخ التسجيل',
            value: DateFormat('yyyy/MM/dd - HH:mm')
                .format(testResult.recordedAt.toLocal()),
            valueColor: Colors.grey[700]!,
          ),

          SizedBox(
            height: size.height * .015,
          ),

          DetailRow(
            icon: Icons.person_outline,
            label: 'مسجل النتيجة',
            value: testResult.recordedBy.name,
            valueColor: Colors.grey[700]!,
          ),

          if (testResult.notes.isNotEmpty) ...[
            SizedBox(
              height: size.height * .015,
            ),

            TestResultNotes(
              notes: testResult.notes,
            ),
          ],
        ],
      ),
    );
  }
}