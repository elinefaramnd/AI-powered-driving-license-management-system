import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class AppointmentLocationSection extends StatelessWidget {
  final String location;

  const AppointmentLocationSection({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          color: AppColors.primaryColor,
          size: size.width * .06,
        ),

        SizedBox(width: size.width * .015),

        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.width * .038,
            ),
          ),
        ),
      ],
    );
  }
}