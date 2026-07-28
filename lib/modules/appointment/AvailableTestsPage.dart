import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/available_tests/locked_test_card.dart';
import '../../widgets/available_tests/main_test_card.dart';
import '../../widgets/available_tests/order_info_card.dart';
import '../../widgets/available_tests/progress_tracker.dart';
import '../../widgets/custom_app_bar.dart';
import 'AvailableTestsController.dart';

class AvailableTestsPage extends StatelessWidget {
  AvailableTestsPage({super.key});

  final controller = Get.put(AvailableTestsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Get.locale?.languageCode == "ar";
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F4),
      appBar: CustomAppBar(
        title: "available_tests".tr,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final availableTest = controller.tests.firstWhereOrNull(
          (e) => e["can_book"] == true && e["is_available"] == true,
        );
        print("AVAILABLE TEST = $availableTest");
        return SingleChildScrollView(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Directionality(
            textDirection:
            isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                OrderInfoCard(),
                SizedBox(height: size.width * 0.03),
                ProgressTracker(tests: controller.tests),
                SizedBox(height: size.width * 0.03),
                ...controller.tests.map((test) {
                  final state = controller.getTestState(test["code"]);

                  return Padding(
                    padding: EdgeInsets.only(bottom: size.width * 0.025),
                    child: state["status"] == "available"
                        ? MainTestCard(availableTest: test)
                        : LockedTestCard(
                            title: controller.getArabicName(test["code"]),
                            icon: controller.getIcon(test["code"]),
                            line1: state["text"],
                            line2: controller.formatReason(state["reason"]),
                          ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
