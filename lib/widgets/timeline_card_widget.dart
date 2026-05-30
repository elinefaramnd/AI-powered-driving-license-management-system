import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../modules/home_page/home_controller.dart';
import 'step_widget.dart';
import 'line_widget.dart';

class TimelineCardWidget extends StatelessWidget {
  const TimelineCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Obx(() {
      final status = controller.currentApplicationStatus.value;
      final hasApplication = controller.hasApplication.value;
      bool createDone = false;
      bool docsDone = false;
      bool paymentDone = false;
      bool createActive = false;
      bool docsActive = false;
      bool paymentActive = false;
      if (!hasApplication || status.isEmpty || status == "-") {
        createDone = false;
        docsDone = false;
        paymentDone = false;
        createActive = true;
      } else if (status == "documents_under_review") {
        createDone = true;
        docsActive = true;
      } else if (status == "payment_pending") {
        createDone = true;
        docsDone = true;
        paymentActive = true;
      }
      return Container(
        padding: EdgeInsets.all(w * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "تقدم الطلب",
                style: TextStyle(
                  fontSize: w * 0.044,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            SizedBox(height: h * 0.012),
            Row(
              children: [
                StepWidget(
                  title: "إنشاء الطلب",
                  icon: Icons.edit,
                  done: createDone,
                  active: createActive,
                ),
                LineWidget(),
                StepWidget(
                  title: "مراجعة الوثائق",
                  icon: Icons.fact_check,
                  done: docsDone,
                  active: docsActive,
                ),
                LineWidget(),
                StepWidget(
                  title: "الدفع",
                  icon: Icons.payment,
                  done: paymentDone,
                  active: paymentActive,
                ),
                LineWidget(),
                const StepWidget(title: "الاختبارات", icon: Icons.quiz),
                LineWidget(),
                const StepWidget(title: "إصدار رخصة", icon: Icons.badge),
              ],
            ),
          ],
        ),
      );
    });
  }
}
