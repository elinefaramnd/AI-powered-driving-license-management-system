import 'package:flutter/material.dart';
import '../../../modules/my_licenses/license_model.dart';
import 'card_body.dart';
import 'card_header.dart';

class RenewableLicenseCard extends StatelessWidget {
  final LicenseModel license;

  const RenewableLicenseCard({super.key, required this.license});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CardHeader(license: license),
          CardBody(license: license),
        ],
      ),
    );
  }
}
