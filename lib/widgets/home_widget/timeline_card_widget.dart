import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';
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
      final isReplacement =
          controller.currentServiceCode.value == "lost_replacement" ||
              controller.currentServiceCode.value == "damaged_replacement"||
              controller.currentServiceCode.value == "license_unblock";;
      bool createDone = false;
      bool docsDone = false;
      bool paymentDone = false;
      bool createActive = false;
      bool docsActive = false;
      bool paymentActive = false;
      bool testsDone = false;
      bool testsActive = false;
      bool licenseDone = false;
      bool licenseActive = false;
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
      }else if (status == "appointment_pending" || status == "in_testing") {
        createDone = true;
        docsDone = true;
        paymentDone = true;

        //testsActive = true;
        if (!isReplacement) {
          testsActive = true;
        }
      }

      else if (status == "waiting_retest") {

        createDone = true;
        docsDone = true;
        paymentDone = true;
        // testsActive = true;
        // testsDone = false;
        if (!isReplacement) {
          testsActive = true;
          testsDone = false;
        }
      }
      else if (status == "approved") {
        createDone = true;
        docsDone = true;
        paymentDone = true;
        // testsDone = true;
        //
        // licenseActive = true;
        if (isReplacement) {
          licenseActive = true;
        } else {
          testsDone = true;
          licenseActive = true;
        }
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
                "application_progress".tr,
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
                  title: "create_request".tr,
                  icon: Icons.edit,
                  done: createDone,
                  active: createActive,
                ),
                LineWidget(),
                StepWidget(
                  title: "documents_review".tr,
                  icon: Icons.fact_check,
                  done: docsDone,
                  active: docsActive,
                ),
                LineWidget(),
                StepWidget(
                  title: "payment".tr,
                  icon: Icons.payment,
                  done: paymentDone,
                  active: paymentActive,
                ),
                if (!isReplacement) ...[
                  LineWidget(),
                  StepWidget(
                    title: "tests".tr,
                    icon: Icons.quiz,
                    done: testsDone,
                    active: testsActive,
                  ),
                ],
                LineWidget(),
                StepWidget(
                  title: "license_issue".tr,
                  icon: Icons.badge,
                  done: licenseDone,
                  active: licenseActive,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
