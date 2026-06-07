import 'package:flutter/material.dart';
import '../../../app_theme/app_colors.dart';

class OrderInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const OrderInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(width: 13),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xffF2F7F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}