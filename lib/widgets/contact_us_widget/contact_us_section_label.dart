import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';

class ContactUsSectionLabel extends StatelessWidget {
  final double w;
  final String label;
  final IconData icon;
  const ContactUsSectionLabel({super.key, required this.w, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: w * 0.045,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        SizedBox(width: w * 0.025),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.lightGreenBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.mediumGreen, size: 20),
        ),
      ],
    );
  }
}
