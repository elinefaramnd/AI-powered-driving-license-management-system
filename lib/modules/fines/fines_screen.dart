import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/fines_widget/empty_fines_widget.dart';
import '../../widgets/fines_widget/fine_card.dart';
import '../../widgets/fines_widget/fines_summary_card.dart';
import 'fines_controller.dart';
class FinesScreen extends StatelessWidget {
  FinesScreen({super.key});
  final controller = Get.put(FinesController());
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: CustomAppBar(
        title:  "my_fines".tr,
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
            Text(
              textAlign: TextAlign.start,
              "violations_list".tr,
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
                  Icon(
                    Icons.lightbulb_outline,
                    color: const Color(0xff7C6A3D),
                    size: MediaQuery.of(context).size.width * 0.085,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Text(
                      "fines_notice".tr,
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: const Color(0xff7C6A3D),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
