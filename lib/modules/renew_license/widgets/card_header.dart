import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../modules/my_licenses/license_model.dart';
import '../renew_license_controller.dart';

class CardHeader extends StatelessWidget {
  final LicenseModel license;

  const CardHeader({super.key, required this.license});

  String get _remainingDays {
    final expiry = DateTime.tryParse(license.expiryDate);
    if (expiry == null) return '';
    final difference = expiry.difference(DateTime.now()).inDays;
    if (difference > 0) return 'متبقي $difference يوم';
    if (difference == 0) return 'تنتهي اليوم';
    return 'منتهية منذ ${difference.abs()} يوم';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RenewLicenseController>();
    final statusColor = controller.getStatusColor(license.status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: statusColor, size: 22),
              const SizedBox(width: 8),
              Text(
                controller.getStatusText(license.status),
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _remainingDays,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
