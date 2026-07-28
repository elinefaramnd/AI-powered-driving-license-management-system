import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'appointment_info_item.dart';

class AppointmentInfoSection extends StatelessWidget {
  final String date;
  final String day;
  final String time;

  const AppointmentInfoSection({
    super.key,
    required this.date,
    required this.day,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppointmentInfoItem(
          icon: Icons.date_range,
          title: "date".tr,
          value: date,
        ),

        AppointmentInfoItem(
          icon: Icons.today,
          title: "day".tr,
          value: day,
        ),

        AppointmentInfoItem(
          icon: Icons.access_time,
          title: "time".tr,
          value: time,
        ),
      ],
    );
  }
}