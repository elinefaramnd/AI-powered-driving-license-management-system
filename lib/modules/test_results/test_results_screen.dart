// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_2/modules/test_results/test_result_card.dart';
// import '../../app_theme/app_colors.dart';
// import '../../widgets/custom_app_bar.dart';
// import '../../widgets/test_result/empty_state.dart';
// import '../../widgets/test_result/summary_section.dart';
// import 'test_results_controller.dart';
//
// class TestResultsScreen extends StatelessWidget {
//   final controller = Get.put(TestResultsController());
//
//   TestResultsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: "my_test_results".tr,
//       ),
//       body: Obx(() {
//         if (controller.loading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(
//                   color: AppColors.primary,
//                   strokeWidth: 3,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "loading_test_results".tr,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         if (controller.testResults.isEmpty) {
//           return EmptyState(
//             controller: controller,
//           );
//         }
//
//         return CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: SummarySection(
//                 controller: controller,
//               ),
//             ),
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                     return TestResultCard(
//                       testResult: controller.testResults[index],
//                     );
//                   },
//                   childCount: controller.testResults.length,
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: SizedBox(height: 30),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }