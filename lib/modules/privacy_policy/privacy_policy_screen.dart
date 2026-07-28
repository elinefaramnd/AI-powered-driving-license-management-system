import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/widgets/custom_app_bar.dart';
import 'privacy_policy_controller.dart';
import '../../widgets/privacy_policy_widget/privacy_policy_hero_banner.dart';
import '../../widgets/privacy_policy_widget/privacy_policy_section_card.dart';
import '../../widgets/privacy_policy_widget/privacy_policy_error_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PrivacyPolicyController>()
        ? Get.find<PrivacyPolicyController>()
        : Get.put(PrivacyPolicyController());
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final isArabic = Get.locale?.languageCode == "ar";

    return Scaffold(
      appBar: CustomAppBar(title:  "privacy_policy".tr,),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return PrivacyPolicyErrorWidget(
              w: w,
              controller: controller,
            );
          }

          final policy = controller.policy.value;
          if (policy == null) return const SizedBox.shrink();

          return Column(
            children: [
             // PrivacyPolicyAppBar(w: w),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment:
                    isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                     // _PageTitle(w: w),
                      SizedBox(height: h * 0.018),
                      PrivacyPolicyHeroBanner(
                        w: w,
                        h: h,
                        lastUpdated: policy.lastUpdated,
                      ),
                      SizedBox(height: h * 0.025),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                        itemCount: policy.sections.length,
                        separatorBuilder: (_, __) => SizedBox(height: h * 0.012),
                        itemBuilder: (_, index) {
                          final section = policy.sections[index];
                          return Obx(() {
                            final isExpanded =
                                controller.expandedSections.length > index &&
                                    controller.expandedSections[index];
                            return PrivacyPolicySectionCard(
                              w: w,
                              h: h,
                              index: index,
                              heading: section.heading,
                              content: section.content,
                              isExpanded: isExpanded,
                              controller: controller,
                            );
                          });
                        },
                      ),
                      SizedBox(height: h * 0.025),
                    ],
                  ),
                ),
              ),
              _BottomButton(w: w, h: h),
            ],
          );
        }),
      ),
    );
  }
}


class _BottomButton extends StatelessWidget {
  final double w;
  final double h;
  const _BottomButton({required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Container(
      padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.015, w * 0.05, h * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: h * 0.065,
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF042E2B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Row(
            textDirection:
            isArabic ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined, color: Colors.white, size: 20),
              SizedBox(width: w * 0.02),
              Text(
                "privacy_policy_read".tr,
                textAlign:
                isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

