import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/my_licenses/license_card.dart';
import '../../modules/my_licenses/license_model.dart';
import 'lost_replacement_controller.dart';

class LostReplacementScreen extends StatelessWidget {
  const LostReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LostReplacementController>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColors.primaryColor,
          title: const Text(
            'بدل فاقد',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.licenses.isEmpty) {
            return _buildEmptyState();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اختر الرخصة المفقودة',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...controller.licenses.map((license) => _LostReplacementLicenseCard(
                  license: license,
                  onCreate: () => controller.createLostReplacement(license),
                  isCreating: controller.creating.value,
                  isEligible: controller.isEligible(license),
                )),
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
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
              'لا توجد رخص',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'لم يتم إصدار أي رخصة لك حتى الآن',
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

class _LostReplacementLicenseCard extends StatelessWidget {
  final LicenseModel license;
  final VoidCallback onCreate;
  final bool isCreating;
  final bool isEligible;

  const _LostReplacementLicenseCard({
    required this.license,
    required this.onCreate,
    required this.isCreating,
    required this.isEligible,
  });

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isCreating || !isEligible) ? null : onCreate,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey[400],
        ),
        child: isCreating
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                isEligible ? 'إصدار بدل فاقد' : 'غير مؤهل لبدل فاقد',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );

    return LicenseCard(
      license: license,
      action: button,
    );
  }
}
