import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
class AppointmentInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const AppointmentInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: size.width * .055,
                ),
                SizedBox(width: size.width * .015),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * .035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * .004),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.width * .034,
              ),
            ),
          ],
        ),
      ),
    );
  }
}