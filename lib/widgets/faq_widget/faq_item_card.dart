import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/faq/faq_model.dart';

class FaqItemCard extends StatelessWidget {
  final double w;
  final FaqItem faq;
  final int number;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqItemCard({
    super.key,
    required this.w,
    required this.faq,
    required this.number,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded
                ? AppColors.primary.withOpacity(0.3)
                : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? AppColors.primary
                        : AppColors.lightGreenBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: isExpanded ? Colors.white : AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$number. ${faq.question}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: w * 0.037,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAF8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  faq.answer,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: w * 0.034,
                    color: Colors.grey.shade700,
                    height: 1.7,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
