import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

import '../../widgets/faq_widget/faq_app_bar.dart';
import '../../widgets/faq_widget/faq_category_header.dart';
import '../../widgets/faq_widget/faq_contact_banner.dart';
import '../../widgets/faq_widget/faq_error_widget.dart';
import '../../widgets/faq_widget/faq_item_card.dart';
import '../../widgets/faq_widget/faq_search_bar.dart';
import 'faq_controller.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<FaqController>()
        ? Get.find<FaqController>()
        : Get.put(FaqController());
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
        title: const Text(
          'الأسئلة الشائعة',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: h * 0.02),
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
                'لا توجد نتائج',
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
      separatorBuilder: (_, _) => SizedBox(height: h * 0.01),
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
