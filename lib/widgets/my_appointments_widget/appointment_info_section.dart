import 'package:flutter/material.dart';

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
          title: "التاريخ",
          value: date,
        ),

        AppointmentInfoItem(
          icon: Icons.today,
          title: "اليوم",
          value: day,
        ),

        AppointmentInfoItem(
          icon: Icons.access_time,
          title: "الوقت",
          value: time,
        ),
      ],
    );
  }
}