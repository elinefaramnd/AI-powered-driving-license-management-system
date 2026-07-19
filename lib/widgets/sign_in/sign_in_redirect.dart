import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';

class SignInRedirect extends StatelessWidget {
  const SignInRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(
          "no_account".tr,
          style: TextStyle(fontSize: screenWidth * 0.038),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed('/signUp');
          },
          child: Text(
            "create_account".tr,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: screenWidth * 0.038,
            ),
          ),
        ),


      ],
    );
  }
}
