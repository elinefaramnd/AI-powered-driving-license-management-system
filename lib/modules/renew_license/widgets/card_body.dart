import 'package:flutter/material.dart';
import '../../../modules/my_licenses/license_model.dart';
import 'info_row.dart';
import 'renew_button.dart';

class CardBody extends StatelessWidget {
  final LicenseModel license;

  const CardBody({super.key, required this.license});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            icon: Icons.badge_outlined,
            label: 'رقم الرخصة',
            value: license.licenseNumber,
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.directions_car_outlined,
            label: 'نوع الرخصة',
            value: license.licenseType.name,
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'تاريخ الانتهاء',
            value: license.expiryDate,
          ),
          const SizedBox(height: 20),
          RenewButton(license: license),
        ],
      ),
    );
  }
}
