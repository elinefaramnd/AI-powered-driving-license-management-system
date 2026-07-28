import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class SecurityNote extends StatelessWidget {
  const SecurityNote({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final w=size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.verified_user_outlined,
          size: 16,
          color: AppColors.primaryColor,
        ),
        SizedBox(width:w*.02),
        Text(
    "secure_payments".tr,
          style: TextStyle(
            fontSize:w*.031,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
