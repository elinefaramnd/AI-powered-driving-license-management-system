import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/fines_widget/empty_fines_widget.dart';
import '../../widgets/fines_widget/fine_card.dart';
import '../../widgets/fines_widget/fines_summary_card.dart';
import 'fines_controller.dart';
class FinesScreen extends StatelessWidget {
  FinesScreen({super.key});
  final controller = Get.put(FinesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("غراماتي"),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.all(18),
          children: [
            FinesSummaryCard(),
            const SizedBox(height: 12),
            const Text(
              textAlign: TextAlign.end,
              "قائمة المخالفات",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            if (controller.fines.isEmpty)
              const EmptyFinesWidget()
            else
              ...controller.fines.map((e) => FineCard(fine: e)),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.022,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF8F3E7),
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.025,
                ),
                border: Border.all(color: const Color(0xffD9C79D), width: 1.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "عزيزي السائق، يرجى تسديد الغرامات خلال 30 يوماً لتجنب أي رسوم إضافية أو إجراءات قانونية",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xff7C6A3D),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Icon(
                    Icons.lightbulb_outline,
                    color: const Color(0xff7C6A3D),
                    size: MediaQuery.of(context).size.width * 0.085,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
