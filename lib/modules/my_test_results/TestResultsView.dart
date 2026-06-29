import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/my_test_results/result_card.dart';
import '../../widgets/my_test_results/result_footer.dart';
import 'test_results_controller.dart';

class TestResultsView extends StatelessWidget {
  TestResultsView({super.key});

  final controller = Get.put(TestResultsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final padding = size.width * 0.04;
    final mediumSpace = size.height * 0.025;
    final titleFont = size.width * 0.045;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "نتائج اختباراتي",
            style: TextStyle(
              fontSize: titleFont,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: const SizedBox(),
          actions: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (controller.results.isEmpty) {
            return const Center(
              child: Text("لا توجد نتائج"),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.results.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: mediumSpace),
                  itemBuilder: (context, index) {
                    return ResultCard(
                      size: size,
                      item: controller.results[index],
                      controller: controller,
                    );
                  },
                ),

                SizedBox(height: mediumSpace),

                ResultFooter(size: size),
              ],
            ),
          );
        }),
      ),
    );
  }
}