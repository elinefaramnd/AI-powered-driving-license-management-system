import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../modules/my_transactions/my_transactions_controller.dart';

class TransactionsTabs extends StatelessWidget {
  final MyTransactionsController controller;

  const TransactionsTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Obx(
          () => Container(
        margin: EdgeInsets.symmetric(horizontal: w * .045),
        padding: EdgeInsets.all(w * .012),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * .04),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _TabItem(
                title: 'my_application_payments'.tr,
                icon: Icons.description_outlined,
                selected: controller.selectedTab.value == 0,
                onTap: () => controller.changeTab(0),
              ),
            ),
            Expanded(
              child: _TabItem(
                title: 'my_fine_payments'.tr,
                icon: Icons.warning_amber_outlined,
                selected: controller.selectedTab.value == 1,
                onTap: () => controller.changeTab(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          vertical: w * .035,
          horizontal: w * .02,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(w * .032),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: w * .05,
              color: selected
                  ? Colors.white
                  : Colors.grey[600],
            ),
            SizedBox(width: w * .018),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.grey[700],
                  fontSize: w * .032,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}