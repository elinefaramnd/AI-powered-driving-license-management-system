import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class AppointmentTopSection extends StatelessWidget {
  final String code;
  final String title;

  const AppointmentTopSection({
    super.key,
    required this.code,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        CircleAvatar(
          radius: size.width * .055,
          backgroundColor: const Color(0xffF2F4F7),
          child: Icon(
            code == "vision"
                ? Icons.visibility
                : Icons.description,
            color: AppColors.primaryColor,
          ),
        ),

        SizedBox(width: size.width * .025),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * .04,
              ),
            ),

            Text(
              _getDescription(code),
              style: TextStyle(
                fontSize: size.width * .03,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getDescription(String code) {
    switch (code) {
      case "vision":
        return "vision_test_desc".tr;
      case "theory":
        return "theory_test_desc".tr;
      case "practical":
        return "practical_test_desc".tr;
      default:
        return "";
    }
  }
}