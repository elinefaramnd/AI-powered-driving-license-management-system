import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/available_tests/step_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/appointment/AvailableTestsController.dart';

class ProgressTracker extends StatelessWidget {
  final controller = Get.find<AvailableTestsController>();
  final List tests;

   ProgressTracker({
    super.key,
    required this.tests,
  });

  @override
  Widget build(BuildContext context) {

    final visionState = controller.getTestState("vision");
    final theoryState = controller.getTestState("theory");
    final practicalState = controller.getTestState("practical");

    return Row(
      children: [
        StepWidget(
          title: "اختبار النظر",
          icon: Icons.remove_red_eye_outlined,
          active: visionState["status"] != "locked",
          done: visionState["status"] == "done",
        ),
        _Line(active: true),
        StepWidget(
          title: "الاختبار النظري",
          icon: Icons.menu_book_outlined,
          active: theoryState["status"] != "locked",
          done: theoryState["status"] == "done",
        ),
        _Line(active: false),
        StepWidget(
          title: "الاختبار العملي",
          icon: Icons.drive_eta_outlined,
          active: practicalState["status"] != "locked",
          done: practicalState["status"] == "done",
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  final bool active;
  const _Line({required this.active});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: size.width * 0.005,
        color: active
            ? AppColors.primaryColor.withOpacity(.5)
            : Colors.grey.shade400,
      ),
    );
  }
}