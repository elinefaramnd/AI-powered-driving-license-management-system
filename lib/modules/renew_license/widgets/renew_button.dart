import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../modules/my_licenses/license_model.dart';
import '../renew_license_controller.dart';

class RenewButton extends StatelessWidget {
  final LicenseModel license;

  const RenewButton({super.key, required this.license});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RenewLicenseController>();
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        final isLoading = controller.creatingRenewal.value;
        return ElevatedButton(
          onPressed: isLoading ? null : () => controller.createRenewal(license),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey[400],
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'تجديد الرخصة',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
        );
      }),
    );
  }
}
