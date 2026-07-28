import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class FaqCategoryChips extends StatelessWidget {
  final double w;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelected;

  const FaqCategoryChips({
    super.key,
    required this.w,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'الحساب والملف الشخصي':
      case 'Account & Profile':
        return Icons.person_outline_rounded;
      case 'الطلبات والخدمات':
      case 'Applications & Services':
        return Icons.assignment_outlined;
      case 'الوثائق والدفع':
      case 'Documents & Payment':
        return Icons.description_outlined;
      case 'المواعيد والاختبارات':
      case 'Appointments & Tests':
        return Icons.calendar_today_outlined;
      case 'الرخص والمخالفات':
      case 'Licenses & Violations':
        return Icons.credit_card_outlined;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _getShortLabel(String category) {
    switch (category) {
      case 'الحساب والملف الشخصي':
      case 'Account & Profile':
        return "account".tr;

      case 'الطلبات والخدمات':
      case 'Applications & Services':
        return "applications".tr;

      case 'الوثائق والدفع':
      case 'Documents & Payment':
        return "payment".tr;

      case 'المواعيد والاختبارات':
      case 'Appointments & Tests':
        return "tests".tr;

      case 'الرخص والمخالفات':
      case 'Licenses & Violations':
        return "licenses".tr;

      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: isArabic,
        padding: EdgeInsets.symmetric(horizontal: w * 0.045),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => onSelected(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getCategoryIcon(cat),
                    size: 16,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getShortLabel(cat),
                    style: TextStyle(
                      fontSize: w * 0.032,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
