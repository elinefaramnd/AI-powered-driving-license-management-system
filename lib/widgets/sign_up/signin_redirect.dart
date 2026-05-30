import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class SignInRedirect extends StatelessWidget {
  const SignInRedirect({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.toNamed('/signIn');
          },
          child: const Text(
            "تسجيل الدخول",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        const Text("لديك حساب بالفعل؟"),
      ],
    );
  }
}
