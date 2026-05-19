import 'package:flutter/material.dart';
import 'step_widget.dart';
import 'line_widget.dart';
import '../app_theme/app_colors.dart';

class TimelineCardWidget extends StatelessWidget {
  const TimelineCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("تقدم الطلب",
              style: TextStyle(
                  fontSize: w * 0.044,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen)),
          SizedBox(height: h * 0.012),
          Row(
            children: [
              StepWidget(title: "إنشاء الطلب", done: true, icon: Icons.edit),
              LineWidget(),
              StepWidget(title: "مراجعة الوثائق", done: true, icon: Icons.fact_check),
              LineWidget(),
              StepWidget(title: "الدفع", active: true, icon: Icons.payment),
              LineWidget(),
              StepWidget(title: "الاختبارات", icon: Icons.quiz),
              LineWidget(),
              StepWidget(title: "إصدار رخصة", icon: Icons.badge),
            ],
          ),
        ],
      ),
    );
  }
}