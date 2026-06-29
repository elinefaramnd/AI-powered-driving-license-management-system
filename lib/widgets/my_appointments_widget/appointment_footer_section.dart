import 'package:flutter/material.dart';
import 'appointment_action_button.dart';
import 'appointment_status_chip.dart';

class AppointmentFooterSection extends StatelessWidget {
  final bool completed;
  final String result;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const AppointmentFooterSection({
    super.key,
    required this.completed,
    required this.result,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (completed) {
      return AppointmentStatusChip(
        result: result,
      );
    }

    return Row(
      children: [
        AppointmentActionButton(
          text: "تعديل الموعد",
          onTap: onEdit,
        ),

        SizedBox(
          width: size.width * .025,
        ),

        AppointmentActionButton(
          text: "إلغاء الموعد",
          onTap: onCancel,
        ),
      ],
    );
  }
}