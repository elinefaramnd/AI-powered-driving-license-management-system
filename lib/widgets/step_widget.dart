import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class StepWidget extends StatelessWidget {
  final String title;
  final bool done;
  final bool active;
  final IconData icon;

  const StepWidget({
    super.key,
    required this.title,
    required this.icon,
    this.done = false,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = done
        ? AppColors.primary
        : active
        ? const Color(0xff988561)
        : Colors.grey.shade300;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(done ? Icons.check : icon,
              color: Colors.white, size: 16),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 55,
          child: Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10)),
        ),
      ],
    );
  }
}