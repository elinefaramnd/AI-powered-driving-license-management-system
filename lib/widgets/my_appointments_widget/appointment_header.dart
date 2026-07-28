import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          color: AppColors.primaryColor,
          size: size.width * .06,
        ),
        SizedBox(width: size.width * .02),
        Text(
    "upcoming_appointments".tr,
          style: TextStyle(
            fontSize: size.width * .045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}