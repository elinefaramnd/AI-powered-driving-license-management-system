import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../modules/my_licenses/license_model.dart';
import '../renew_license_controller.dart';
import 'renewable_license_card.dart';

class RenewLicenseBody extends StatelessWidget {
  const RenewLicenseBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RenewLicenseController>();
    return Obx(() {
      if (controller.loading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      }
      if (controller.renewableLicenses.isEmpty) {
        return const RenewEmptyState();
      }
      return RenewLicensesList(licenses: controller.renewableLicenses);
    });
  }
}

class RenewEmptyState extends StatelessWidget {
  const RenewEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.gold,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'لا توجد رخص متاحة للتجديد',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'يجب أن تكون الرخصة نشطة أو منتهية لإمكانية التجديد',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RenewLicensesList extends StatelessWidget {
  final List<LicenseModel> licenses;

  const RenewLicensesList({super.key, required this.licenses});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر رخصة للتجديد',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...licenses.map((license) => RenewableLicenseCard(license: license)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
