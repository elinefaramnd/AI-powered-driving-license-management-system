import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
class AppointmentStatusChip extends StatelessWidget {
  final String result;

  const AppointmentStatusChip({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .025,
        vertical: size.height * .007,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          size.width * .015,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
            size: size.width * .04,
          ),
          SizedBox(width: size.width * .01),
          Text(
            result,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * .035,
            ),
          ),
        ],
      ),
    );
  }
}