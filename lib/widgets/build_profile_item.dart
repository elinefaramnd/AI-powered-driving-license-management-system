
import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

Widget buildProfileItem({
  required String title,
  required String value,
  required IconData icon,
}) {

  return Container(

    margin: const EdgeInsets.only(bottom: 10),

    padding: const EdgeInsets.all(7),

    decoration: BoxDecoration(

      color: Colors.white,

      borderRadius: BorderRadius.circular(16),

      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),

    child: Row(

      children: [
        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style:  TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),


        const SizedBox(width: 28),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.primaryColor
                .withOpacity(0.1),
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),


      ],
    ),
  );
}