import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import 'license_card.dart';
import 'my_licenses_controller.dart';

class MyLicensesScreen extends StatelessWidget {
  final controller = Get.put(MyLicensesController());

  MyLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "my_licenses".tr,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (controller.licenses.isEmpty) {
          return _buildEmptyState();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment:
            isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              // Stats Row
              _buildStatsRow(),
              const SizedBox(height: 24),
              // Section Header with filter
              Row(
                mainAxisAlignment: isArabic
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  // Filter button
                  // Section title
                  Row(
                    textDirection:
                    isArabic ? TextDirection.rtl : TextDirection.ltr,
                    children: [
                      Text(
                        "licenses_list".tr,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 3,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Licenses List
              ...controller.licenses
                  .map((license) => LicenseCard(license: license))
                  .toList(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatsRow() {
    final isArabic = Get.locale?.languageCode == "ar";
    return Obx(() {
      final activeCount =
          controller.licenses.where((l) => l.status == 'active').length;
      final totalCount = controller.licenses.length;

      return Row(
        children: [
          // Active licenses card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    activeCount.toString(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "active_licenses".tr,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Total licenses card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Icon(
                      Icons.badge_outlined,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    totalCount.toString(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "total_licenses".tr,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card_off_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              "no_licenses".tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "no_licenses_message".tr,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
