import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/my_licenses/license_model.dart';

class LicenseInfoSection extends StatelessWidget {
  final LicenseModel license;
  const LicenseInfoSection({super.key, required this.license});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _rowItem(
          Icons.badge_outlined,
          "license_number".tr,
          license.licenseNumber,
        ),
        Divider(color: Colors.grey.shade200),
        _rowItem(
          _getLicenseTypeIcon(license.licenseType.code),
          "license_type".tr,
          license.licenseType.name,
        ),
        Divider(color: Colors.grey.shade200),
        Row(
          children: [
            Expanded(
              child: _dateItem("issue_date_label".tr, license.issueDate),
            ),
            Container(width: 1, height: 34, color: Colors.grey.shade200),
            Expanded(
              child: _dateItem("expiry_date_label".tr, license.expiryDate),
            ),
          ],
        ),
      ],
    );
  }
}
IconData _getLicenseTypeIcon(String code) {
  switch (code.toLowerCase()) {
    case 'truck':
      return Icons.local_shipping_outlined;
    case 'bus':
      return Icons.directions_bus_outlined;
    case 'private':
      return Icons.directions_car_outlined;
    case 'public':
      return Icons.local_taxi_outlined;
    default:
      return Icons.directions_car_outlined;
  }
}
Widget _rowItem(IconData icon, String label, String value) {
  return Builder(
    builder: (context) {
      final w = MediaQuery.of(context).size.width;

      return Row(
        children: [
          Container(
            width: w * .10,
            height: w * .10,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F7F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryColor),
          ),
          SizedBox(width: w * .03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey.shade600)),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
Widget _dateItem(String label, String value) {
  return Builder(
    builder: (context) {
      final w = MediaQuery.of(context).size.width;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
                SizedBox(width: w * .015),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: w * .024,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w * .015),
            Text(
              value,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: w * .031,
              ),
            ),
          ],
        ),
      );
    },
  );
}
