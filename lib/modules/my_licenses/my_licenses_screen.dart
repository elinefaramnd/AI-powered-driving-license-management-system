import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/my_licenses_widget/empty_licenses_state.dart';
import '../../widgets/my_licenses_widget/license_card.dart';
import '../../widgets/my_licenses_widget/licenses_section_header.dart';
import 'my_licenses_controller.dart';

class MyLicensesScreen extends StatelessWidget {
  final controller = Get.put(MyLicensesController());
  MyLicensesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isArabic = Get.locale?.languageCode == "ar";
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F6),
      appBar: CustomAppBar(title: "my_licenses".tr),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (controller.licenses.isEmpty) {
          return const EmptyLicensesState();
        }
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            media.size.width * 0.035,
            media.size.height * 0.012,
            media.size.width * 0.035,
            media.size.height * 0.022,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatsSection(controller: controller),

              SizedBox(height: media.size.height * 0.02),

              LicensesSectionHeader(isArabic: isArabic),

              SizedBox(height: media.size.height * 0.015),

              ...controller.licenses.map(
                (license) => LicenseCard(license: license),
              ),

              SizedBox(height: media.size.height * 0.005),
            ],
          ),
        );
      }),
    );
  }
}

class _StatsSection extends StatelessWidget {
  final MyLicensesController controller;

  const _StatsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final activeCount = controller.licenses
        .where((e) => e.status.toLowerCase() == "active")
        .length;

    final totalCount = controller.licenses.length;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: "active_licenses".tr,
            value: activeCount.toString(),
            active: true,
          ),
        ),
        SizedBox(width: w * .025),
        Expanded(
          child: _StatCard(
            title: "total_licenses".tr,
            value: totalCount.toString(),
            active: false,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool active;

  const _StatCard({
    required this.title,
    required this.value,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: w * .19,
      padding: EdgeInsets.all(w * .02),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF2FAF4) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? const Color(0xFFD8ECD9) : Colors.grey.shade200,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: w * .085,
                    height: w * .085,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      active ? Icons.verified : Icons.badge_outlined,
                      color: AppColors.primaryColor,
                      size: w * .045,
                    ),
                  ),
                  SizedBox(width: w * .025),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: w * .055,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: w * .033,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
