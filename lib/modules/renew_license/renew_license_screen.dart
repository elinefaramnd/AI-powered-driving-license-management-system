import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'renew_license_controller.dart';
import 'widgets/renew_license_app_bar.dart';
import 'widgets/renew_license_body.dart';

class RenewLicenseScreen extends StatelessWidget {
  RenewLicenseScreen({super.key}) {
    Get.put(RenewLicenseController());
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: RenewLicenseAppBar(),
        body: RenewLicenseBody(),
      ),
    );
  }
}
