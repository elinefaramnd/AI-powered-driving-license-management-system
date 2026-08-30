import 'package:flutter/material.dart';
import '../../../app_theme/app_colors.dart';

class NotificationTabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final int? count;
  final VoidCallback onTap;

  const NotificationTabItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .045,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: selected ? AppColors.primaryColor : Colors.grey.shade700,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                fontSize: size.width * .033,
              ),
            ),

            if (count != null && count! > 0) ...[
              const SizedBox(width: 6),

              Container(
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
