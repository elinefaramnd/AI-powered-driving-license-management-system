import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
class AppointmentActionButton extends StatelessWidget {
  final String text;

  const AppointmentActionButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * .01,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(
            size.width * .02,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: size.width * .035,
            ),
          ),
        ),
      ),
    );
  }
}