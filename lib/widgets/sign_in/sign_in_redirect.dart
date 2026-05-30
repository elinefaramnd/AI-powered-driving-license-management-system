import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';

class SignInRedirect extends StatelessWidget {
  const SignInRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        TextButton(
          onPressed: () {
            Get.toNamed('/signUp');
          },

          child: Text(
            "إنشاء حساب جديد",

            style: TextStyle(
              color: AppColors.primaryColor,

              fontSize: screenWidth * 0.038,
            ),
          ),
        ),

        Text("ليس لديك حساب؟", style: TextStyle(fontSize: screenWidth * 0.038)),
      ],
    );
  }
}
