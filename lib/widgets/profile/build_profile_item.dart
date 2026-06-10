import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

Widget buildProfileItem({
  required BuildContext context,
  required String title,
  required String value,
  required IconData icon,
}) {
  final size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(bottom: size.height * 0.012),

    padding: EdgeInsets.all(size.width * 0.018),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(size.width * 0.04),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          blurRadius: size.width * 0.025,
          offset: Offset(0, size.height * 0.005),
        ),
      ],
    ),

    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(title, style: TextStyle(color: Colors.black, fontSize: size.width * 0.033,)),

              SizedBox(height: size.height * 0.005),

              Text(
                value,
                style: TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.07),
        Container(
          width: size.width * 0.08,
          height: size.width * 0.08,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(size.width * 0.03),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: size.width * 0.05,),
        ),
      ],
    ),
  );
}
