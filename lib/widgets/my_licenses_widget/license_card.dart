import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:project_2/widgets/my_licenses_widget/unblock_license_button.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/create_application_step1.dart';
import '../../modules/my_licenses/license_model.dart';
import '../../modules/my_licenses/my_licenses_controller.dart';
import '../../widgets/my_licenses_widget/download_license_button.dart';
import 'license_application_section.dart';
import 'license_header.dart';
import 'license_info_section.dart';

class LicenseCard extends StatelessWidget {
  final LicenseModel license;

  const LicenseCard({
    super.key,
    required this.license,
  });
  String getRemainingDays() {
    final expiry = DateTime.parse(license.expiryDate);
    final difference = expiry.difference(DateTime.now()).inDays;
    if (difference > 0) {
      return "remaining_days".trParams({
        "days": difference.toString(),
      });
    }
    if (difference == 0) {
      return "expires_today".tr;
    }
    return "expired_since".trParams({
      "days": difference.abs().toString(),
    });
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: media.size.height * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          LicenseHeader(
            license: license,
            statusText: license.status,
          ),

          Padding(
            padding: EdgeInsets.all(media.size.width * .04),
            child: Column(
              children: [
                LicenseInfoSection(license: license),

                SizedBox(height: media.size.height * .015),

                LicenseApplicationSection(
                  license: license,
                  remainingDays: getRemainingDays(),
                ),

                SizedBox(height: media.size.height * .015),

                DownloadLicenseButton(
                  onPressed: () {
                    final controller = Get.find<MyLicensesController>();
                    controller.downloadLicense(license.id);
                  },
                ),

                if (license.canRequestUnblock) ...[
                  SizedBox(height: media.size.height * .015),
                  UnblockLicenseButton(
                    onPressed: () {
                      Get.to(
                            () => CreateApplicationStep1(),
                        arguments: license.id,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}