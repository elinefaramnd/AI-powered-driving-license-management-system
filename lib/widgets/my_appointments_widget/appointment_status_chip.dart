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

    IconData icon;
    Color color;

    switch (result) {
      case "passed":
        icon = Icons.check_circle;
        color = AppColors.primaryColor;
        break;

      case "failed":
        icon = Icons.cancel;
        color = Colors.red;
        break;

      case "pending":
        icon = Icons.hourglass_empty;
        color = Colors.orange;
        break;

      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .025,
        vertical: size.height * .007,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size.width * .015),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
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
  }}