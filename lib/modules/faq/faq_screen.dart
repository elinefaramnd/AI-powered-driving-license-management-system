import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/custom_app_bar.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/faq_widget/faq_app_bar.dart';
import '../../widgets/faq_widget/faq_category_header.dart';
import '../../widgets/faq_widget/faq_contact_banner.dart';
import '../../widgets/faq_widget/faq_error_widget.dart';
import '../../widgets/faq_widget/faq_item_card.dart';
import '../../widgets/faq_widget/faq_search_bar.dart';
import 'faq_controller.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<FaqController>()
        ? Get.find<FaqController>()
        : Get.put(FaqController());
    final isArabic = Get.locale?.languageCode == "ar";
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: "faq".tr,),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mediumGreen),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return FaqErrorWidget(
              w: w,
              h: h,
              message: controller.errorMessage.value,
              onRetry: controller.fetchFaqs,
            );
          }

          if (controller.filteredFaqs.isEmpty && controller.faqList.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
             // FaqAppBar(w: w),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // SizedBox(height: h * 0.015),
                      // _PageTitle(w: w),
                      SizedBox(height: h * 0.018),
                      FaqHeroBanner(w: w, h: h),
                      SizedBox(height: h * 0.02),
                      FaqSearchBar(
                        w: w,
                        searchController: controller.searchController,
                        onChanged: controller.onSearchChanged,
                      ),
                      SizedBox(height: h * 0.018),
                      Obx(() => FaqCategoryChips(
                            w: w,
                            categories: controller.categories.toList(),
                            selectedCategory:
                                controller.selectedCategory.value,
                            onSelected: controller.selectCategory,
                          )),
                      SizedBox(height: h * 0.018),
                      Obx(() => _buildFaqList(w, h, controller)),
                      SizedBox(height: h * 0.025),
                    ],
                  ),
                ),
              ),
              FaqContactBanner(w: w, h: h),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildFaqList(double w, double h, FaqController controller) {
    final faqs = controller.filteredFaqs;

    if (faqs.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.05),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.search_off_rounded,
                  color: Colors.grey.shade400, size: 48),
              const SizedBox(height: 12),
              Text(
                "no_results".tr,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: w * 0.04,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
      itemCount: faqs.length,
      separatorBuilder: (_, __) => SizedBox(height: h * 0.01),
      itemBuilder: (_, index) {
        final faq = faqs[index];
        return Obx(() => FaqItemCard(
              w: w,
              faq: faq,
              number: index + 1,
              isExpanded: controller.expandedIndex.value == index,
              onTap: () => controller.toggleExpanded(index),
            ));
      },
    );
  }
}

class _PageTitle extends StatelessWidget {
  final double w;
  const _PageTitle({required this.w});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'faq'.tr,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: w * 0.072,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF042E2B),
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
